
  create view "postgres"."public_pipedrive_analytics"."int_deal_changes_dedupe_stage__dbt_tmp"
    
    
  as (
    -- This intermediate model does the following:
	-- Separates the stages from the deal_changes model
	-- Adds the friendly stages label to the deal_changes data.
	-- Deduplicates a handful of dupe deals in the deal_changes model
		-- Assumption: deals should not arrive at the same stage more than once
			-- Note: it might be possible in the real world, but this rule was checked by looking at the deals that also had more than one add date, which definitely seems incorrect.
		-- Assumption: the latest lost reason is the one that should be presented to the model
		-- Method: row_number in reverse order and then pick the first row. 
		-- This pattern is better when we don't know how many duplicate rows there could be, but the latest will always be row number 1.
		-- Can't just take MAX(new_value) as was done for new_deals, because that would pick the largest given lost reason id, which would be incorrect.

-- materialized view to apply built-in test unique values after dedupe


WITH deal_changes_stage AS (
	SELECT
		ROW_NUMBER() OVER(PARTITION BY deal_id, new_value ORDER BY new_value, change_time DESC) AS reverse_order,
		deal_id,
		new_value AS stage_id,
		change_time,
		month_name,
		month_number
	FROM "postgres"."public_pipedrive_analytics"."stg_pipedrive__deal_changes"
	WHERE changed_field_key = 'stage_id'
),
deal_changes_stage_cast_id AS (
	SELECT
		deal_id,
		CAST(stage_id AS INTEGER) AS stage_id, -- do it here once rather than twice in the final select & join clauses
		change_time,
		month_name,
		month_number
	FROM deal_changes_stage
	WHERE reverse_order = 1
)
SELECT
dcs.deal_id,
dcs.stage_id,
stages.label,
dcs.change_time,
dcs.month_name,
dcs.month_number
FROM deal_changes_stage_cast_id dcs
INNER JOIN "postgres"."public_pipedrive_analytics"."stg_pipedrive__fields_stages" stages
ON dcs.stage_id = stages.id
  );
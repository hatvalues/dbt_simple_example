-- Separate new deals model from the deal_changes model
-- There are a handful of dupe deals in the deal_changes model (assumption - deals should not have more of each stage id)
-- Materialize as a view so it can be tested for deduplication
-- Method: row_number in reverse order and then pick the first row. 
-- This pattern is better because we don't know how many duplicate rows there could be, but the latest will always be row number 1.
-- Can't just take MAX(new_value) as was done for new_deals, because there are multiple stage_ids and all that appear need to be presented to the model.
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
/* NOT USED UPSTREAM. 
    The requested report does not call for lost reason information, so this model is not used anywhere upstream.
	This model is created for completeness and consistent modeling.
NOT USED UPSTREAM. */

-- This intermediate model does the following:
	-- Separates the lost reason from the deal_changes model
	-- Adds the friendly lost reason label to the deal_changes data.
	-- Deduplicates a handful of dupe deals in the deal_changes model
		-- Assumption: deals should not have more than one lost reason
		-- Assumption: the latest lost reason is the one that should be presented to the model
		-- Method: row_number in reverse order and then pick the first row. 
		-- This pattern is better when we don't know how many duplicate rows there could be, but the latest will always be row number 1.
		-- Can't just take MAX(new_value) as was done for new_deals, because that would pick the largest given lost reason id, which would be incorrect.

-- materialized view to apply built-in test unique values after dedupe


WITH deal_changes_lost_reason AS (
	SELECT
		ROW_NUMBER() OVER(PARTITION BY deal_id ORDER BY change_time DESC) AS reverse_order,
		deal_id,
		new_value AS lost_reason_id,
		change_time,
		month_name,
		month_number
	FROM "postgres"."public_pipedrive_analytics"."stg_pipedrive__deal_changes"
	WHERE changed_field_key = 'lost_reason'
),
deal_changes_lost_reason_cast_id AS (
	SELECT
		deal_id,
		CAST(lost_reason_id AS INTEGER) AS lost_reason_id, -- do it here once rather than twice in the final select & join clauses
		change_time,
		month_name,
		month_number
	FROM deal_changes_lost_reason
	WHERE reverse_order = 1
)
SELECT
dcr.deal_id,
dcr.lost_reason_id,
lost_reasons.label,
dcr.change_time,
dcr.month_name,
dcr.month_number
FROM deal_changes_lost_reason_cast_id dcr
INNER JOIN "postgres"."public_pipedrive_analytics"."stg_pipedrive__fields_lost_reasons" lost_reasons
ON dcr.lost_reason_id = lost_reasons.id
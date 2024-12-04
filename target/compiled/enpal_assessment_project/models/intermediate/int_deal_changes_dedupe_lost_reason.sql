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
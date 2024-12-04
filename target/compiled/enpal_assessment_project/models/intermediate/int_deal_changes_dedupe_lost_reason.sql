WITH deal_changes_lost_reason AS (
	SELECT
		ROW_NUMBER() OVER(PARTITION BY deal_id ORDER BY change_time DESC) AS reverse_order,
		deal_id,
		new_value AS lost_reason,
		change_time,
		month_name,
		month_number
	FROM "postgres"."public_pipedrive_analytics"."stg_pipedrive__deal_changes"
	WHERE changed_field_key = 'lost_reason'
)
SELECT
	deal_id,
	lost_reason,
	change_time,
	month_name,
	month_number
FROM deal_changes_lost_reason WHERE reverse_order = 1
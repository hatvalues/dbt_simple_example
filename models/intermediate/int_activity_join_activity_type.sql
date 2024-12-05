-- Simple intermediate model to join activity and activity_types
-- thus providing the friendly name of the activity type for downstream models
SELECT
	a.user_id,
	a.deal_id,
	t.activity_name,
	ms.stage_id,
	ms.minor_stage_id,
	t.is_active, -- this would be a mart level filter: business logic determines when to include deactivated activity types
	a.is_done, -- this would be a report level filter: analyst determines when to exclude incomplete activities
	a.due_time,
	a.month_name,
	a.month_number
FROM {{ ref('stg_pipedrive__activity') }} a
INNER JOIN {{ ref('stg_pipedrive__activity_types') }} t
	ON a.activity_type = t.activity_type
INNER JOIN {{ ref('minor_stages')}} ms
	ON t.activity_type = ms.activity_type
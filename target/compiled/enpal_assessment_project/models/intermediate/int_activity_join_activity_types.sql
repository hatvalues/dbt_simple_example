-- Simple Intermediate Model to join activity and activity_types
-- thus providing the friendly name of the activity type


SELECT
	a.user_id,
	a.deal_id,
	t.activity_name,
	a.is_done,
	a.due_time
FROM "postgres"."public_pipedrive_analytics"."stg_pipedrive__activity" a
INNER JOIN "postgres"."public_pipedrive_analytics"."stg_pipedrive__activity_types" t
	ON a.activity_type = t.activity_type
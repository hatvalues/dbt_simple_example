with __dbt__cte__int_activity_join_activity_type as (
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
FROM "postgres"."public_pipedrive_analytics"."stg_pipedrive__activity" a
INNER JOIN "postgres"."public_pipedrive_analytics"."stg_pipedrive__activity_types" t
	ON a.activity_type = t.activity_type
INNER JOIN "postgres"."public"."minor_stages" ms
	ON t.activity_type = ms.activity_type
) -- brings in the activity data for deals in the deal_changes table with the same deal_id
-- These will just be the ones with call activities against them

-- Note that there are very few rows compared to the total number of deals
    -- This is because there are very few matching deal ids in deal_changes and activity tables
    -- I have looked at whether this can be an out by N error on the ids but didn't find a fix
-- Potential problem? Why are there so many rows in the activity table with deal ids that don't exist in the deal_changes table?

SELECT
    nd.deal_id,
    act.activity_name,
    act.stage_id,
    act.minor_stage_id,
    act.is_active, -- this would be a mart level filter: business logic determines when to include deactivated activity types
    act.is_done, -- this would be a report level filter: analyst determines when to exclude incomplete activities
    act.month_number,
    act.month_name
FROM "postgres"."public_pipedrive_analytics"."int_deal_changes_dedupe_new_deal" nd
INNER JOIN __dbt__cte__int_activity_join_activity_type act -- result of INNER JOIN is very few rows. Is it a problem?
ON nd.deal_id = act.deal_id
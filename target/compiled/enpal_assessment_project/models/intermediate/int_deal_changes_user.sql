-- Simple Intermediate Model to separate the user_id changes from the deal_changes model
-- There is no need to deduplicate this model because the date of the change can be used to determine the last user_id in a given time interval (e.g. Month)


SELECT
	deal_id,
	new_value AS user_id,
	change_time
FROM "postgres"."public_pipedrive_analytics"."stg_pipedrive__deal_changes"
WHERE changed_field_key = 'user_id'
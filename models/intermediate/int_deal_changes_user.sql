/* NOT USED UPSTREAM. 
    The requested report does not call for user information, so this model is not used anywhere upstream.
	This model is created for completeness and consistent modeling.
NOT USED UPSTREAM. */

-- Simple intermediate model to separate the user_id changes from the deal_changes model
-- There is no need to deduplicate this model because the date of the change can be used to determine the last user_id in a given time interval (e.g. Month)
SELECT
	deal_id,
	new_value AS user_id,
	change_time,
	month_name,
	month_number
FROM {{ ref('stg_pipedrive__deal_changes') }}
WHERE changed_field_key = 'user_id'
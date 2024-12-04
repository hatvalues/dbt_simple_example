-- Assert that the change_time is equal to the new_value when the changed_field_key is 'add_time'
-- With this test, it's OK to ignore the new_value field for add_time changes
SELECT * FROM "postgres"."public_pipedrive_analytics"."stg_pipedrive__deal_changes"
	WHERE changed_field_key = 'add_time'
	AND change_time != new_value::TIMESTAMP
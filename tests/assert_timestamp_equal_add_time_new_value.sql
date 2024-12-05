-- Proving that the new_value field for add_time changes is redundant. We can just use the change_time.
SELECT * FROM {{ ref('stg_pipedrive__deal_changes')}}
	WHERE changed_field_key = 'add_time'
	AND change_time != new_value::TIMESTAMP
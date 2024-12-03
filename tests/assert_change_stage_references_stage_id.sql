-- CTE to pre-filter deal_changes for stage_id changes
-- to safely cast new_value to an integer when we're sure all the values can be implicitly casted
WITH deal_change_stage AS (
	SELECT changed_field_key, new_value FROM deal_changes
	WHERE changed_field_key = 'stage_id'
)
SELECT *
FROM deal_change_stage d
LEFT OUTER JOIN {{ ref('stg_pipedrive__stages') }} s
ON CAST(d.new_value AS INTEGER) = s.id
WHERE s.id IS NULL -- Any non referential values in d will return a NULL s.id
-- new_value field is a STRING type but contains mixed values for other tables/models
-- The CTE will pre-filter the deal_changes to safely cast new_value to an integer for this test
WITH deal_change_stage AS (
	
SELECT
    changed_field_key,
    new_value
FROM
    "postgres"."public_pipedrive_analytics"."stg_pipedrive__deal_changes"
WHERE
    changed_field_key = 'stage_id'

)
SELECT *
FROM deal_change_stage dcs
LEFT OUTER JOIN "postgres"."public_pipedrive_analytics"."stg_pipedrive__fields_stages" stages
ON CAST(dcs.new_value AS INTEGER) = stages.id
WHERE stages.id IS NULL -- Any non referential values in d will return a NULL s.id
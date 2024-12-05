-- new_value field is a STRING type but contains mixed values for other tables/models
-- The CTE will pre-filter the deal_changes to safely cast new_value to an integer for this test
WITH deal_change_reasons AS (
	
SELECT
    changed_field_key,
    new_value
FROM
    "postgres"."public_pipedrive_analytics"."stg_pipedrive__deal_changes"
WHERE
    changed_field_key = 'lost_reason'

)
SELECT *
FROM deal_change_reasons dcr
LEFT OUTER JOIN "postgres"."public_pipedrive_analytics"."stg_pipedrive__fields_lost_reasons" reasons
ON CAST(dcr.new_value AS INTEGER) = reasons.id
WHERE reasons.id IS NULL -- Any non referential values in dcr will return a NULL reasons.id
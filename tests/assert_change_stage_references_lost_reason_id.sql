-- new_value field is a STRING type but contains mixed values for other tables/models
-- The CTE will pre-filter the deal_changes to safely cast new_value to an integer for this test
WITH deal_change_reasons AS (
	{{ get_deal_changes_by('lost_reason') }}
)
SELECT *
FROM deal_change_reasons dcr
LEFT OUTER JOIN {{ ref('stg_pipedrive__fields_lost_reasons') }} reasons
ON CAST(dcr.new_value AS INTEGER) = reasons.id
WHERE reasons.id IS NULL -- Any non referential values in dcr will return a NULL reasons.id
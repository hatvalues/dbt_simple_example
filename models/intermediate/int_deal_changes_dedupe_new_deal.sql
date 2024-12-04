-- Separate new deals model from the deal_changes model
-- There are a handful of dupe deals in the deal_changes model (assumption - deals should not have more than one added date)
-- Materialize as a view so it can be tested for deduplication
SELECT
	deal_id, 
	MAX(change_time) AS created_time
FROM {{ ref('stg_pipedrive__deal_changes') }}
WHERE changed_field_key = 'add_time'
GROUP BY
	deal_id
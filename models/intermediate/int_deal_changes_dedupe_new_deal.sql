-- This intermediate model does the following:
	-- Separates new deals from the deal_changes model
	-- Deduplicates a handful of dupe deals in the deal_changes model
	  -- Assumption: deals should not have more than one added date
	  -- Assumption: the latest added date is the one that should be presented to the model
	  -- Method: simple MAX

-- materialized view to apply built-in test unique values after dedupe
{{ config(materialized='view') }}

SELECT
	deal_id, 
	MAX(change_time) AS created_time
FROM {{ ref('stg_pipedrive__deal_changes') }}
WHERE changed_field_key = 'add_time'
GROUP BY
	deal_id
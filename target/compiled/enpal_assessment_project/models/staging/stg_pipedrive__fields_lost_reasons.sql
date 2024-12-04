-- This model is generated from the `base_pipedrive__fields` model, which has the values buried in a JSON array.
-- ids should be INTEGER as a rule, even though one DBT test is comparing this to a STRING, I still prefer to cast to INTEGER here and in the test.
-- because in the real world, collaborators would be confused to see numeric-looking values as STRINGs.
WITH expand_array AS (
	SELECT 
		jsonb_array_elements(field_value_options) AS field_value_options
	FROM "postgres"."public_pipedrive_analytics"."base_pipedrive__fields"
	WHERE field_key = 'lost_reason'
)
SELECT
	CAST(field_value_options ->> 'id' AS INTEGER) AS id,
	field_value_options ->> 'label' AS label
FROM expand_array
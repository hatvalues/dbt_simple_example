-- `base_pipedrive__fields` model has the values buried in a JSON array.
-- Make sure ids are INTEGER and not numeric-looking STRING 
	-- it is better to convert here even though CASTING is also required in the referential test.
	-- because in the real world, collaborators would be confused to see numeric-looking values as STRINGs.
WITH expand_array AS (
	SELECT 
		jsonb_array_elements(field_value_options) AS field_value_options
	FROM "postgres"."public_pipedrive_analytics"."base_pipedrive__fields"
	WHERE field_key = 'stage_id'
)
SELECT
	CAST(field_value_options ->> 'id' AS INTEGER) AS id,
	field_value_options ->> 'label' AS label
FROM expand_array
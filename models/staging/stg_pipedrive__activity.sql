-- Type is a reserved keyword. Renaming.
-- Rename others for consistency with other models
    -- model.id, model.reference_model_id
    -- bools are prefixed with is_ or has_
    -- convert date strings to timestamps and rename
-- add calculated month fields that will be used downstream

-- Potential problem? Activity ids are not unique on their own.
    -- Combinations repeating activity id with all other columns
    -- Not useful to create a composite unique check
    -- Does not seem to affect the overall task because the relationship to deal_id is more important

WITH base_activity AS (
    SELECT
        activity_id AS id,
        type AS activity_type,
        assigned_to_user AS user_id,
        deal_id,
        done AS is_done,
        due_to::TIMESTAMP AS due_time
    FROM {{ source('postgres_public','activity') }}
)
SELECT 
    id,
    activity_type,
    user_id,
    deal_id,
    is_done,
    due_time,
    {{ add_month_fields('due_time') }}
FROM base_activity
-- This model is generated from the `activity_types` table in the `pipedrive` schema.
-- Renaming a couple of columns to avoid using reserved keywords
-- The `active` column is a string with just two possible value. It makes more sense as a bool
SELECT
    id,
    name AS activity_name,
    CASE
        WHEN active = 'Yes' THEN TRUE
        ELSE FALSE
    END AS activity_is_active,
    type AS activity_type
FROM {{ source('postgres_public','activity_types') }}
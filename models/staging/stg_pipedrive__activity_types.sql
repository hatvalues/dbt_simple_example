-- This model is generated from the `activity_types` table in the `pipedrive` schema.
-- Renaming a couple of columns to avoid using reserved keywords
SELECT
    id,
    name AS activity_name,
    CASE
        WHEN active = 'Yes' THEN TRUE
        ELSE FALSE
    END AS is_active,
    type AS activity_type
FROM {{ source('postgres_public','activity_types') }}
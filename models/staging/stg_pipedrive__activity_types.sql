-- Type and Name are reserved keywords. Renaming.
-- The `active` column is a string with just two possible value. It makes more sense as a bool
SELECT
    id,
    name AS activity_name,
    CASE
        WHEN active = 'Yes' THEN TRUE
        ELSE FALSE
    END AS is_active,
    type AS activity_type
FROM {{ source('postgres_public','activity_types') }}
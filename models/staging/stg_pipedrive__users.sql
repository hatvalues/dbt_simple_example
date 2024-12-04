-- This model is generated from the `users` table in the `pipedrive` schema.
-- Renaming a couple of columns to avoid using reserved keywords and standardise
WITH base_users AS (
    SELECT
        id,
        name AS user_name,
        email AS user_email,
        modified::TIMESTAMP AS modified_time
    FROM {{ source('postgres_public','users') }}
)
SELECT
    id,
    user_name,
    user_email,
    modified_time,
    {{ add_month_fields('modified_time') }}
FROM base_users
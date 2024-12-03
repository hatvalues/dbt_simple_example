-- This model is generated from the `users` table in the `pipedrive` schema.
-- Renaming a couple of columns to avoid using reserved keywords and standardise
SELECT
    id,
    name AS user_name,
    email AS user_email,
    modified AS modified_date
FROM "postgres"."public"."users"
-- Name is a reserved keyword. Renaming.
-- Convert date strings to timestamps and rename
-- Add calculated month fields that will be used downstream
WITH base_users AS (
    SELECT
        id,
        name AS user_name,
        email AS user_email,
        modified::TIMESTAMP AS modified_time
    FROM "postgres"."public"."users"
)
SELECT
    id,
    user_name,
    user_email,
    modified_time,
    
    EXTRACT(MONTH FROM modified_time) AS month_number,
    TO_CHAR(modified_time, 'Month') AS month_name

FROM base_users
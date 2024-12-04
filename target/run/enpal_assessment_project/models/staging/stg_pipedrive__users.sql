
  create view "postgres"."public_pipedrive_analytics"."stg_pipedrive__users__dbt_tmp"
    
    
  as (
    -- This model is generated from the `users` table in the `pipedrive` schema.
-- Renaming a couple of columns to avoid using reserved keywords and standardise
SELECT
    id,
    name AS user_name,
    email AS user_email,
    modified::TIMESTAMP AS modified_time
FROM "postgres"."public"."users"
  );
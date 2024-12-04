
  create view "postgres"."public_pipedrive_analytics"."stg_pipedrive__activity_types__dbt_tmp"
    
    
  as (
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
FROM "postgres"."public"."activity_types"
  );

  create view "postgres"."public_pipedrive_analytics"."stg_pipedrive__deal_changes__dbt_tmp"
    
    
  as (
    -- This model is generated from the `deal_changes` table in the `pipedrive` schema.
-- This is not a source deals table, and deal_id is not a PK (UNIQUE), so leave deal_id named as is
WITH base_deal_changes AS (
    SELECT
        deal_id,
        change_time::TIMESTAMP AS change_time,
        changed_field_key,
        new_value
    FROM "postgres"."public"."deal_changes"
)
SELECT
    deal_id,
    changed_field_key,
    new_value,
    change_time,
    
    EXTRACT(MONTH FROM change_time) AS month_number,
    TO_CHAR(change_time, 'Month') AS month_name

FROM base_deal_changes
  );
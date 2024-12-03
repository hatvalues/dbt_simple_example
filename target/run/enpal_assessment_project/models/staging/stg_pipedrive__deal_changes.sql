
  create view "postgres"."public_pipedrive_analytics"."stg_pipedrive__deal_changes__dbt_tmp"
    
    
  as (
    SELECT
    deal_id AS id,
    change_time,
    changed_field_key,
    new_value
FROM "postgres"."public"."deal_changes"
  );
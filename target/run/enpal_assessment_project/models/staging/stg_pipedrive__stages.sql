
  create view "postgres"."public_pipedrive_analytics"."stg_pipedrive__stages__dbt_tmp"
    
    
  as (
    SELECT
    stage_id AS id,
    stage_name
FROM "postgres"."public"."stages"
  );
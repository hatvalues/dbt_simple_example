
  create view "postgres"."public_pipedrive_analytics"."stg_pipedrive__activity_types__dbt_tmp"
    
    
  as (
    SELECT *
FROM "postgres"."public"."activity_types"
  );
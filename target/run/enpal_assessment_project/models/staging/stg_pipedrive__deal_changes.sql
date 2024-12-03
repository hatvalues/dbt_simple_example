
  create view "postgres"."public_pipedrive_analytics"."stg_pipedrive__deal_changes__dbt_tmp"
    
    
  as (
    SELECT *
FROM "postgres"."public"."deal_changes"
  );
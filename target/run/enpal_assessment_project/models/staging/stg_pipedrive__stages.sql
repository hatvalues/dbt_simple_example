
  create view "postgres"."public_pipedrive_analytics"."stg_pipedrive__stages__dbt_tmp"
    
    
  as (
    SELECT *
FROM "postgres"."public"."stages"
  );
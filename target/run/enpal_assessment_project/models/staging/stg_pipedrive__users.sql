
  create view "postgres"."public_pipedrive_analytics"."stg_pipedrive__users__dbt_tmp"
    
    
  as (
    SELECT *
FROM "postgres"."public"."users"
  );
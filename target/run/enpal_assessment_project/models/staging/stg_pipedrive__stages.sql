
  create view "postgres"."public_pipedrive_analytics"."stg_pipedrive__stages__dbt_tmp"
    
    
  as (
    /* NOT USED. 
    The source table has it's origins in the fields table, which is not used in the final model.
    I would rather keep stages and lost_reasons standardised in the final model.
    My assumption is that the fields table is used to store custom fields,
    and if this were to be updated by a sysadmin, the static stages table would not reflect the changes.
NOT USED. */

-- This model is generated from the `stages` table in the `pipedrive` schema.
-- Renaming a couple of columns to avoid using reserved keywords and standardise
SELECT
    stage_id AS id,
    stage_name
FROM "postgres"."public"."stages"
  );
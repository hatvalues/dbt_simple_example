
  create view "postgres"."public_pipedrive_analytics"."stg_pipedrive__stages__dbt_tmp"
    
    
  as (
    /* NOT USED UPSTREAM. 
    The values in this table also found in the JSON array of base_pipedrive__fields.
    I would rather standardise the way stages and lost_reasons are handled.
    My assumption is that base_pipedrive__fields holds the current values configured in the Pipedrive application,
    and if this were to be updated by a sysadmin, the static version of the stages table would not reflect the changes.
NOT USED UPSTREAM. */

-- Rename stage_id to id for consistency: model.id, model.reference_model_id
SELECT
    stage_id AS id,
    stage_name
FROM "postgres"."public"."stages"
  );
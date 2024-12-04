
  
    

  create  table "postgres"."public_pipedrive_analytics"."mrt_deals_stages__dbt_tmp"
  
  
    as
  
  (
    SELECT
    deal_id,
    stage_id,
    label,
    NULL AS minor_stage_id,
    month_name,
    month_number
FROM "postgres"."public_pipedrive_analytics"."int_deal_changes_dedupe_stage"
  );
  

  
    

  create  table "postgres"."public_pipedrive_analytics"."mrt_deals_stages__dbt_tmp"
  
  
    as
  
  (
    SELECT
    nd.deal_id,
    nd.created_time
FROM "postgres"."public_pipedrive_analytics"."int_deal_changes_dedupe_new_deal" nd
  );
  
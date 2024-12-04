
  
    

  create  table "postgres"."public_pipedrive_analytics"."mrt_deals_stages__dbt_tmp"
  
  
    as
  
  (
    WITH all_deal_changes_and_activity AS (
    SELECT
        deal_id,
        stage_id,
        minor_stage_id,
        is_done, -- this would be a report level filter: analyst determines when to exclude incomplete activities
        activity_name AS label,
        month_name,
        month_number
    FROM "postgres"."public_pipedrive_analytics"."int_deal_changes_activity"
    WHERE is_active = TRUE -- Mart level filter, most business users will ignore e.g. 'Follow Up Call' that is set to be inactive
    UNION ALL
    SELECT
        deal_id,
        stage_id,
        NULL AS minor_stage_id,
        NULL AS is_done,
        label,
        month_name,
        month_number
    FROM "postgres"."public_pipedrive_analytics"."int_deal_changes_dedupe_stage"
)
SELECT
    nd.deal_id,
    dca.stage_id,
    dca.minor_stage_id,
    dca.is_done,
    dca.label,
    dca.month_name,
    dca.month_number
FROM "postgres"."public_pipedrive_analytics"."int_deal_changes_dedupe_new_deal" nd -- Only deals from the deal_changes model (these have a created_time)
LEFT OUTER JOIN all_deal_changes_and_activity dca -- This will pick up the minor stages/activities where they exist for this set of deals
    ON nd.deal_id = dca.deal_id
  );
  
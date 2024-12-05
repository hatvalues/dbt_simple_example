select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      -- Assert that there are no duplicate deal-stage pairs in the deal changes table
SELECT
    COUNT(*),
    deal_id,
    stage_id
FROM "postgres"."public_pipedrive_analytics"."int_deal_changes_dedupe_stage"
GROUP BY
    deal_id,
    stage_id
HAVING COUNT(*) > 1
      
    ) dbt_internal_test
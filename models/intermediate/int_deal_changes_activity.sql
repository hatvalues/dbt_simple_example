-- brings in the activity data for each deal in the deal_changes table
-- Note that there are very few rows compared to the total number of deals
-- These will just be the ones with call activities against them
SELECT
    nd.deal_id,
    act.activity_name,
    act.stage_id,
    act.minor_stage_id,
    act.is_active, -- this would be a mart level filter: business logic determines when to include deactivated activity types
    act.is_done, -- this would be a report level filter: analyst determines when to exclude incomplete activities
    act.month_number,
    act.month_name
FROM {{ ref('int_deal_changes_dedupe_new_deal') }} nd
INNER JOIN {{ ref('int_activity_join_activity_type')}} act
ON nd.deal_id = act.deal_id
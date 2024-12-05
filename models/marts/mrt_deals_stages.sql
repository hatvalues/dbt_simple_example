-- This mart model provides a breakdown by month of all deals and their stages, minor stages, and activities.
-- The LEFT OUTER JOIN to the deal_changes model ensures that only deals with an add_time event are included in the final report.
    -- Of course, with different assumptions, we could easily include everything from the activity model.
    -- but the deals that appear only in the activity table don't have an entry point via the Lead Generation stage
    -- and that would make the business logic inconsistent.
    -- A conversation with a stakeholder could lead to a different set of assumptions and a different report.
WITH all_deal_changes_and_activity AS (
    SELECT
        deal_id,
        stage_id,
        minor_stage_id,
        is_done, -- this would be a report level filter: analyst determines when to exclude incomplete activities
        activity_name AS label,
        month_name,
        month_number
    FROM {{ ref('int_deal_changes_activity') }}
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
    FROM {{ ref('int_deal_changes_dedupe_stage') }}
)
SELECT
    nd.deal_id,
    dca.stage_id,
    dca.minor_stage_id,
    dca.is_done,
    dca.label,
    dca.month_name,
    dca.month_number
FROM {{ ref('int_deal_changes_dedupe_new_deal') }} nd -- Only deals from the deal_changes model (these have a created_time)
LEFT OUTER JOIN all_deal_changes_and_activity dca -- This will pick up the minor stages/activities where they exist for this set of deals
    ON nd.deal_id = dca.deal_id

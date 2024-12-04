SELECT
    nd.deal_id,
    nd.created_time
FROM {{ ref('int_deal_changes_dedupe_new_deal') }} nd
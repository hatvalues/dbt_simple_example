SELECT
    COUNT(*),
    deal_id,
    stage_id
FROM {{ ref('int_deal_changes_dedupe_stage') }}
GROUP BY
    deal_id,
    stage_id
HAVING COUNT(*) > 1
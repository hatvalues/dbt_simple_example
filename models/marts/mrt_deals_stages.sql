SELECT
    deal_id,
    stage_id,
    label,
    NULL AS minor_stage_id,
    month_name,
    month_number
FROM {{ ref('int_deal_changes_dedupe_stage') }}


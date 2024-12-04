-- This model is generated from the `deal_changes` table in the `pipedrive` schema.
-- This is not a source deals table, and deal_id is not a PK (UNIQUE), so leave deal_id named as is
WITH base_deal_changes AS (
    SELECT
        deal_id,
        change_time::TIMESTAMP AS change_time,
        changed_field_key,
        new_value
    FROM {{ source('postgres_public','deal_changes') }}
)
SELECT
    deal_id,
    changed_field_key,
    new_value,
    change_time,
    {{ add_month_fields('change_time') }}
FROM base_deal_changes
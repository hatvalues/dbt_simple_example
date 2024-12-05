-- This is not a source deals table, and deal_id is not a PK (UNIQUE)
    -- leave deal_id named as is to be consistent with naming convention model.reference_model_id
    -- convert date strings to timestamps and rename
-- add calculated month fields that will be used downstream
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
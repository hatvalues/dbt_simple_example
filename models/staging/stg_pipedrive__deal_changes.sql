-- This model is generated from the `deal_changes` table in the `pipedrive` schema.
-- Renaming a id column to standardise
SELECT
    deal_id AS id,
    change_time::TIMESTAMP AS change_time,
    changed_field_key,
    new_value
FROM {{ source('postgres_public','deal_changes') }}
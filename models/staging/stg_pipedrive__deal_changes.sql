SELECT
    deal_id AS id,
    change_time,
    changed_field_key,
    new_value
FROM {{ source('postgres_public','deal_changes') }}
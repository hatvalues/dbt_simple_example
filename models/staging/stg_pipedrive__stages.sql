SELECT
    stage_id AS id,
    stage_name
FROM {{ source('postgres_public','stages') }}
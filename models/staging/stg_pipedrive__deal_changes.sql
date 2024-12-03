SELECT *
FROM {{ source('postgres_public','deal_changes') }}
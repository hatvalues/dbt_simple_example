SELECT *
FROM {{ source('postgres_public','fields') }}
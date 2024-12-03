-- This model is generated from the `stages` table in the `pipedrive` schema.
-- Renaming a couple of columns to avoid using reserved keywords and standardise
SELECT
    stage_id AS id,
    stage_name
FROM "postgres"."public"."stages"
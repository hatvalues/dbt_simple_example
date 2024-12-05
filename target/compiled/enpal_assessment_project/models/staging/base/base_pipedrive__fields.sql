-- Simple base model to connect to the source table
-- This table has JSON array values that need to be unpacked
-- Those unpacked values will be set up as reference nodes in the staging layer
SELECT *
FROM "postgres"."public"."fields"
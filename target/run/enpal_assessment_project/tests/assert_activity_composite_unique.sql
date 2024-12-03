select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      -- Activity table can have duplicate activity_id
-- but must differ in either type and/or assigned_to_user

WITH count_rows AS (
SELECT
    activity_id,
    type,
    assigned_to_user,
    ROW_NUMBER() OVER(PARTITION BY activity_id, type, assigned_to_user) AS cnt
FROM "postgres"."public"."activity"
)
SELECT * FROM count_rows
WHERE cnt >=2
      
    ) dbt_internal_test
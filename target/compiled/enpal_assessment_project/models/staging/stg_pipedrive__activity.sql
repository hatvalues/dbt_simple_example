-- This model is a staging table for the activity table in the Pipedrive database.
-- Renaming a couple of columns to avoid using reserved keywords
-- Rename others for consistency with other models: model.id, model.reference_model_id
WITH base_activity AS (
    SELECT
        activity_id AS id,
        type AS activity_type,
        assigned_to_user AS user_id,
        deal_id,
        done AS is_done,
        due_to::TIMESTAMP AS due_time
    FROM "postgres"."public"."activity"
)
SELECT 
    id,
    activity_type,
    user_id,
    deal_id,
    is_done,
    due_time,
    
    EXTRACT(MONTH FROM due_time) AS month_number,
    TO_CHAR(due_time, 'Month') AS month_name

FROM base_activity
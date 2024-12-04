-- ASSUMPTIONS FOR THIS MODEL:
-- Show the number of deals in each stage of the sales funnel, for each month
    -- Although we have models for users, they are not needed/requested in this model
    -- Although we have models for lost deals
        -- we are showing the stage the deal was in at the time of the activity 
        -- whether or not it was closed in the end
        -- If it was not closed in the end, it just doesn't get counted in the Closing or later stages
        -- so it doesn't appear necessary to use the lost reasons model

-- create the funnel steps as requested
WITH funnel_step_from_stages AS (
	SELECT
		deal_id,
		month_number,
		month_name,
		CONCAT(stage_id, 
			CASE
				WHEN minor_stage_id IS NULL THEN ''
				ELSE CONCAT('.', minor_stage_id)
			END
		) AS funnel_step,
		label AS kpi_name
	FROM {{ ref('mrt_deals_stages')}} AS funnel
    WHERE COALESCE(is_done, TRUE) -- report level filter: exclude incomplete activities
),
-- aggregate CTE then order, to avoid having to keep the order columns in the view
monthly_agg AS (
	SELECT
		COUNT(deal_id) AS deals_count,
		month_number,
		month_name,
		funnel_step,
		kpi_name
	FROM funnel_step_from_stages
	GROUP BY
		month_number,
		month_name,
		funnel_step,
		kpi_name
)
-- final query with ordering
SELECT
	month_name AS month,
	kpi_name,
	funnel_step,
	deals_count
	FROM monthly_agg
ORDER BY month_number, funnel_step
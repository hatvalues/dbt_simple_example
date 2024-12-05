-- ASSUMPTIONS FOR THIS MODEL:
-- Show the number of deals in each stage of the sales funnel, for each month
	-- I am presenting a historical view, each deal stage at the time it happened
	-- (alternative would have been snapshot of final stages of each deal, that's not what I'm doing here)
    -- Although we have models for users, they are not needed/requested in this model
    -- Although we have models for lost deals
        -- we are showing the stage the deal was in at the time of the activity 
        -- whether or not it was closed in the end
        -- If it was not closed in the end, it just doesn't get counted in the Closing or later stages
        -- so it doesn't appear necessary to use the lost reasons model
	-- As noted in the intermediate model, we are excluding inactive activities
	-- As noted in the intermediate model, there are hardly any activities with deal_ids also in the deal_changes table
		-- this results in very entries for steps 2.1 and 3.1 (only two, in fact)

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
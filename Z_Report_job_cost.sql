-- Job cost report for sales managers
-- THis is a collection of all active jobs with information about the associated costs.

SELECT
  j.Job_Number -- Job Number
  ,j.Job_Description -- Job Description
  ,j.SalesRep_Number AS SalesRep -- Sales rep
  ,j.PM_Number AS PM -- PM

  
-- Cost Type (labor, material, subcontractor, equipment)
-- Est Cost
-- Est Hours
-- Foreman
-- JTD Cost
-- JTD Hours
-- Cost percent complete

-- Projected Cost
-- Projected Hours



-- The following are calculated
----Completion
----Current Cost/HR
----Projected Rate
----Remaining Cost
----Remaining Hours

	--,j.*

FROM
  Z_Active_jobs AS j




-- Job costs by job
SELECT
	TRIM(co.WS_Job_Number) AS Job_Number	-- Job number
	,CASE
		WHEN co.Cost_Element = 1 THEN 'Labor'
		WHEN co.Cost_Element = 2 THEN 'Materials'
		WHEN co.Cost_Element = 3 THEN 'Equipment'
		WHEN co.Cost_Element = 4 THEN 'Tools'
		WHEN co.Cost_Element = 5 THEN 'Other'
		WHEN co.Cost_Element = 6 THEN 'Subcontract'
		WHEN co.Cost_Element = 7 THEN 'Burden'
		WHEN co.Cost_Element = 8 THEN 'Contingency'
	END AS Cost_Type						-- Cost type
	,co.Cost_Code_Act_Cost_TTD AS Actual_Cost -- JTD cost
	,co.Cost_Code_Estimated_Cst AS Estimated_Cost -- Estimated cost
	,co.Cost_Code_Forecast_Cost AS Forecast_Cost -- Projected cost
	,Actual_Units_TTD AS Actual_Hours -- JDT hours
	,co.Cost_Code_Est_Unit AS Estimated_Hours_A -- Estimated hours
	,co.Estimated_Amt_Units AS Estimated_Hours_B
	,co.Forecasted_Units AS Forecast_Hours -- Projected hours
	,'' AS DIV
	--,co.*
FROM
	JC00701 AS co
--WHERE co.Cost_Element = 1
ORDER BY WS_Job_Number DESC



--SELECT * FROM JC00601

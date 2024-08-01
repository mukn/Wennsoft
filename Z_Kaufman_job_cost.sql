-- Job cost query taken from Job Cost for Field Foremen Wennsoft report authored by Chris Kaufman.

SELECT
	-- Information below includes Division assignment, basic job information, assigned personnel, and gross contract amount.
	CASE
		WHEN j.Divisions LIKE '%_SP_%' THEN 'Special Projects'
		WHEN j.Divisions LIKE '%_HVAC_%' THEN 'Service'
		ELSE NULL
	END AS Division
	,CONVERT(date, j.CREATDDT) AS Create_Date
	,TRIM(j.WS_Job_Number) AS Job_Number
	,TRIM(j.WS_Job_Name) AS Job_Name
	,TRIM(j.User_Define_1) AS Job_Description
	,j.Expected_Contract AS Contract
	,CASE
		WHEN CONVERT(int, j.Estimator_ID) > 0 THEN CONVERT(int, j.Estimator_ID)
		ELSE NULL
	END AS Salesman
	,CASE
		WHEN CONVERT(int, j.WS_Manager_ID) > 0 THEN CONVERT(int, j.WS_Manager_ID)
		ELSE NULL
	END AS Project_Manager
	,CASE
		WHEN CONVERT(int, j2.WS_Manager_ID_2) > 0 THEN CONVERT(int, j2.WS_Manager_ID_2)
		ELSE NULL
	END AS Foreman
	-- Begin forcasts
	,j.Total_Forecasted_Cost AS Forecast_Total
	,j.Forecast_Equipment_TTD AS Forecast_Equipment
	,j.Forecasted_Labor_TTD AS Forecast_Labor
	,j.Forecast_Materials_TTD AS Forecast_Materials
	,j.Forecast_UserDef1 AS Forecast_Subcontract
	,j.Forecast_UserDef2 AS Contingency
	-- Begin costs
	,j.Total_Actual_Cost AS Cost_Total
	,j.Act_Labor_Cost_YTD AS Cost_Labor
	,j.Act_Materials_Cost_YTD AS Cost_Materials
	,j.Act_Equipment_Cost_YTD AS Cost_Equipment
	,j.Act_Cost_YTD_UserDef1
	,j.Act_Cost_YTD_UserDef2
	,j.Committed_Cost
	,j.Committed_Equipment_TTD
	,j.Committed_Materials_TTD
	,j.Committed_Labor_TTD
	,j.Committed_Subs_TTD
	,j.Committed_TTD_UserDef1
	,j.Committed_TTD_UserDef2
	,j.Est_Labor_Units_TTD
	,j.Act_Labor_Units_TTD
	,j.Revsd_Forecast_Lab_Units
	,CASE
		WHEN CONVERT(date, j.Last_Billing_Date) > '1901-01-01' THEN CONVERT(date, j.Last_Billing_Date)
		ELSE NULL
	END AS Last_Billing_Date
	,j.Est_Labor_Cost
FROM
	JC00102 AS j
	LEFT OUTER JOIN
	JC00107 AS j2
		ON j.WS_Job_Number = j2.WS_Job_Number

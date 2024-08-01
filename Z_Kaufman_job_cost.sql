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
	END AS Sales_Rep_ID
	,CONCAT(emp_s.Employee_FirstName, ' ', emp_s.Employee_LastName) AS Sales_Rep_Name
	--,emp_s.Employee_FirstName AS Sales_Rep_First_Name
	--,emp_s.Employee_LastName AS Sales_Rep_Last_Name
	,CASE
		WHEN CONVERT(int, j.WS_Manager_ID) > 0 THEN CONVERT(int, j.WS_Manager_ID)
		ELSE NULL
	END AS Project_Manager_ID
	,CONCAT(emp_m.Employee_FirstName, ' ', emp_m.Employee_LastName) AS Project_Manager_Name
	--,emp_m.Employee_FirstName AS Project_Manager_First_Name
	--,emp_m.Employee_LastName AS Project_Manager_Last_Name
	,CASE
		WHEN CONVERT(int, j2.WS_Manager_ID_2) > 0 THEN CONVERT(int, j2.WS_Manager_ID_2)
		ELSE NULL
	END AS Project_Supervisor_ID
	,CONCAT(emp_f.Employee_FirstName, ' ', emp_f.Employee_LastName) AS Project_Supervisor_Name
	--,emp_f.Employee_FirstName AS Project_Supervisor_First_Name
	--,emp_f.Employee_LastName AS Project_Supervisor_Last_Name

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
	
	-- Begin commits
	,j.Committed_Cost AS Committed_Total
	,j.Committed_Equipment_TTD AS Committed_Equipment
	,j.Committed_Materials_TTD AS Committed_Materials
	,j.Committed_Labor_TTD AS Committed_Labor
	,j.Committed_Subs_TTD AS Committed_Subcontract
	,j.Committed_TTD_UserDef1
	,j.Committed_TTD_UserDef2
	
	-- Begin labor hours
	,j.Est_Labor_Units_TTD AS Estimated_Labor_Hours
	,j.Act_Labor_Units_TTD AS Actual_Labor_Hours
	,j.Revsd_Forecast_Lab_Units AS Forecast_Labor_Hours
	,CASE
		WHEN CONVERT(date, j.Last_Billing_Date) > '1901-01-01' THEN CONVERT(date, j.Last_Billing_Date)
		ELSE NULL
	END AS Last_Billing_Date
	,j.Est_Labor_Cost
	
	-- Begin calculated fields
	,j.Forecast_Equipment_TTD - j.Act_Equipment_Cost_YTD AS Remaining_Equipment
	,j.Forecast_Materials_TTD - j.Act_Materials_Cost_YTD AS Remaining_Material
	,CASE
		WHEN j.Est_Labor_Cost > 0 THEN j.Est_Labor_Cost - j.Act_Labor_Cost_YTD
		ELSE NULL
	END AS Remaining_Labor
	,j.Forecast_UserDef1 - j.Act_Cost_YTD_UserDef1 AS Remaining_Subcontract
	,CASE
		WHEN j.Est_Labor_Units_TTD > 0 THEN j.Est_Labor_Units_TTD - j.Act_Labor_Cost_TTD
		ELSE NULL
	END AS Remaining_Hours
	,CASE
		WHEN j.Act_Labor_Units_TTD > 0 THEN j.Act_Labor_Cost_YTD / j.Act_Labor_Units_TTD
		ELSE NULL
	END AS Actual_Labor_Rate
	,CASE
		WHEN j.Est_Labor_Cost > 0 THEN j.Est_Labor_Cost / j.Est_Labor_Units_TTD
		ELSE NULL
	END AS Estimated_Labor_Rate

FROM
	JC00102 AS j
	LEFT OUTER JOIN
	JC00107 AS j2
		ON j.WS_Job_Number = j2.WS_Job_Number
	LEFT JOIN
	Z_Active_employees AS emp_s
		ON CONVERT(int, j.Estimator_ID) = emp_s.Employee_Number
	LEFT JOIN
	Z_Active_employees AS emp_m
		ON CONVERT(int, j.WS_Manager_ID) = emp_m.Employee_Number
	LEFT JOIN
	Z_Active_employees AS emp_f
		ON CONVERT(int, j2.WS_Manager_ID_2) = emp_f.Employee_Number

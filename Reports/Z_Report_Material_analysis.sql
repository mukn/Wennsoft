--ALTER VIEW Z_Report_Material_analysis AS
SELECT
	TRIM(j.WS_Job_Number) AS Job_number,
	--Job_name,
	TRIM(j.WS_Job_Name) AS Job_name,
	--Job_description,
	j.User_Define_1 AS Job_description,
	--Material_cost,
	j.Act_Materials_Cost_TTD AS Material_cost,
	--Material_estimate,
	j.Est_Material_Cost AS Material_estimate,
	--Variance,
	CASE
		WHEN j.Est_Material_Cost > 0 THEN (j.Act_Materials_Cost_TTD / j.Est_Material_Cost) 
		ELSE 0
	END AS Material_variance,
	--Percent_complete,
	j.Est_Pct_Complete_to_Date as Percent_complete,
	--Division,
	j.Divisions AS Division,
	--Status
	s.Status,
	u.Reason AS Material_analysis,
	u.Notes AS Analysis_notes
	
	--,j.*
	--,u.*
FROM
	JC00102 AS j
	LEFT OUTER JOIN
	cstb_JobUDF4Reasons AS u
		ON j.WS_Job_Number = u.WS_Job_Number
	LEFT OUTER JOIN
	(SELECT TRIM(WS_Job_Number) AS Job_number, WS_Job_Type AS Status
	FROM JC00107) AS s
		ON j.WS_Job_Number = s.Job_number

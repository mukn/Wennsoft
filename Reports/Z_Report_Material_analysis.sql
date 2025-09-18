--ALTER VIEW Z_Report_Material_analysis AS
SELECT
	--Status
	j.Status,
	--Job information
	TRIM(j.[Job Number]) AS Job_number,
	TRIM(j.[Job Name]) AS Job_name,
	j.User_Define_1 AS Job_description,
	--Material_cost,
	j.[Act Material] AS Material_cost,
	--Material_estimate,
	j.[Est Material] AS Material_estimate,
	--Variance,
	CASE
		WHEN j.[Est Material] > 0 THEN (j.[Act Material] / j.[Est Material]) 
		ELSE 0
	END AS Material_variance_pct,
	(j.[Act Material] - j.[Est Material]) AS Material_variance_act,
	--Percent_complete,
	j.[Percent Complete] as Percent_complete,
	--Division,
	j.Division AS Division,
	--Material analysis
	u.Reason AS Material_analysis,
	u.Notes AS Analysis_notes
	
	--,j.*
	--,u.*
FROM
	csvw_All_Jobs_Masterv2 AS j
	LEFT OUTER JOIN
	cstb_JobUDF4Reasons AS u
		ON j.[Job Number] = u.WS_Job_Number

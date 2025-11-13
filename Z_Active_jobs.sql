
--ALTER VIEW Z_Active_jobs AS
-- Active jobs
SELECT
	TRIM(j.WS_Job_Number) AS Job_Number
	,TRIM(j.Divisions) AS Division_Code
	,CASE
		WHEN j.Divisions LIKE '%_HVAC_%' THEN 'Service'
		WHEN j.Divisions LIKE '%_SP_%' THEN 'Special Projects'
		ELSE NULL
	END AS Division_name
	,CASE
		WHEN j.Divisions LIKE '%_HVAC_%' THEN 'dispatch@nacgroup.com'
		WHEN j.Divisions LIKE '%_SP_%' THEN 'sp_operations@nacgroup.com'
		ELSE NULL
	END AS Division_email
	,CASE
		WHEN CAST(Estimator_ID AS int) = 0 THEN NULL
		ELSE CAST(Estimator_ID AS int)
	END AS SalesRep_Number
	,NULL AS SalesRep_Name
	,NULL AS SalesRep_Email
	,CASE
		WHEN CAST(WS_Manager_ID AS int) = 0 THEN NULL
		ELSE CAST(WS_Manager_ID AS int)
	END AS PM_Number
	,NULL AS PM_Name
	,NULL AS PM_Email
	,NULL AS Site_ContactName
	,NULL AS Site_ContactEmail
	,TRIM(User_Define_1) AS Job_Description
	,TRIM(j.WS_Job_Name) AS Job_Name
	,TRIM(l.ADDRESS1) AS Job_Address1
	--,TRIM(l.Address2) AS Job_Address2
	,TRIM(l.CITY) AS Job_City
	,TRIM(l.STATE) AS Job_State
	,TRIM(l.ZIP) AS Job_Zip
	,CASE
		WHEN CAST(j.Schedule_Start_Date AS date) = '1900-01-01' THEN NULL
		ELSE CAST(j.Schedule_Start_Date AS date)
	END AS Date_SchedStart
	,CASE
		WHEN CAST(j.Sched_Completion_Date AS date) = '1900-01-01' THEN NULL
		ELSE CAST(j.Sched_Completion_Date AS date)
	END AS Date_SchedComplete
	,CASE
		WHEN CAST(j.ACTCOMPDATE AS date) = '1900-01-01' THEN NULL
		ELSE CAST(j.ACTCOMPDATE AS date)
	END AS Date_ActualComplete
	,u.Superintendent
	,u.Engineer
	,u.Est_hoursOT
	,u.Est_manpower
	,u.Foreman
	,u.Projected_hours
	,u.Date_Salesforce
	,u.Permit_reqd
	,u.Flag_priority
	,TRIM(J.Bill_Customer_Number) AS Customer_Code                            -- For matching against locations.
	,TRIM(J.Job_Address_Code) AS Location_Code                                -- For matching against locations.
	--,*
FROM
	JC00102 AS J	-- By definition, this table contains open jobs
	LEFT JOIN
	Z_All_jobs_udfs AS u
		ON j.WS_Job_Number = u.Job_Number
	LEFT JOIN
	SV00200 AS L
		ON TRIM(J.Bill_Customer_Number) = TRIM(L.CUSTNMBR) 
		AND TRIM(J.Job_Address_Code) = TRIM(L.ADRSCODE)
--ORDER BY Job_Number

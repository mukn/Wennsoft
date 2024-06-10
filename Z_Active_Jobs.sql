SELECT
	TRIM(j.WS_Job_Number) AS Job_Number
	,TRIM(j.Divisions) AS Division_Code
	,NULL AS Division_Name
	,NULL AS Division_Email
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
	,CAST(j.Schedule_Start_Date AS date) AS Date_SchedStart
	,CAST(j.Sched_Completion_Date AS date) AS Date_SchedComplete
	,CAST(j.ACTCOMPDATE AS date) AS Date_ActualComplete
	
	,TRIM(J.Bill_Customer_Number) AS Customer_Code                            -- For matching against locations.
	,TRIM(J.Job_Address_Code) AS Location_Code                                -- For matching against locations.
	,*
FROM
	JC00102 AS J
	JOIN
	SV00200 AS L
		ON TRIM(J.Bill_Customer_Number) = TRIM(L.CUSTNMBR) 
		AND TRIM(J.Job_Address_Code) = TRIM(L.ADRSCODE)
ORDER BY Job_Number

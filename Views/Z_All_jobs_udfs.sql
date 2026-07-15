--ALTER VIEW Z_All_jobs_udfs AS
-- UDF field values
SELECT 
	TRIM(u.WS_Job_Number) AS Job_number
	,CASE
		WHEN u.WS_Manager_ID_2 <> '' THEN CAST(u.WS_Manager_ID_2 AS int)
		ELSE NULL
	END AS Superintendent
	,CASE
		WHEN u.WS_Engineer <> '' THEN CAST(u.WS_Engineer AS int)
		ELSE NULL
	END AS Engineer
	,CASE
		WHEN u.User_Define_1 <> '' THEN CAST(u.User_Define_1 AS int)
		ELSE NULL
	END AS Est_hoursOT
	,CASE
		WHEN u.User_Define_2 <> '' THEN CAST(u.User_Define_2 AS int)
		ELSE NULL
	END AS Est_manpower
	,CASE
		WHEN u.User_Define_3 <> '' THEN CAST(u.User_Define_3 AS int)
		ELSE NULL
	END AS Foreman
	,CASE
		WHEN u.User_Define_4 <> '' THEN CAST(u.User_Define_4 AS int)
		ELSE NULL
	END AS MaterialAnalysis_code
	,CASE
		WHEN u.User_Define_5 <> '' THEN CAST(u.User_Define_5 AS int)
		ELSE NULL
	END AS Projected_hours
	,CASE
		WHEN u.User_Define_6 <> '' THEN u.User_Define_6
		ELSE NULL
	END AS Job_scope
	,CASE
		WHEN u.USRDAT01 <> '' THEN CAST(u.USRDAT01 AS date)
		ELSE NULL
	END AS Date_Salesforce
	,CASE
		WHEN u.User_Defined_CB_1 = 1 THEN 'True'
		ELSE NULL
	END AS Permit_reqd
	,CASE
		WHEN u.User_Defined_CB_2 = 1 THEN 'Priority'
		ELSE NULL
	END AS Flag_priority
	--,u.*

FROM JC00107 AS u		--WHERE WS_Job_Number = '24040940ET'
		-- WS_Manager_ID_2	::	Superintendent
		-- WS_Engineer		::	Engineer
		-- User_Define_1	::	Estimated OT Hours
		-- User_Define_2	::	Estimated Manpower
		-- User_Define_3	::	Foreman
		-- User_Define_4	::	Material Cost Analysis
		-- User_Define_5	::	Projected Hours
		-- User_Define_6	::	Scopes
		-- USRDAT01			::	SalesForce Booking Date
		-- User_Defined_CB_1	::	Permits Required
		-- User_Defined_CB_2	::	Priority Job


/**  -- Update the labels for the fields in JC40101
	UPDATE JC40101
	SET WS_User_Defined_Descript = 'Job scopes'
	WHERE DEX_ROW_ID = 26
	--select * from JC40101

*/

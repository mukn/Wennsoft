--ALTER VIEW Z_All_jobs_udfs AS
-- UDF field values
SELECT 
	TRIM(u.WS_Job_Number) AS Job_number
	,CAST(u.WS_Manager_ID_2 AS int) AS Superintendent
	,CAST(u.WS_Engineer AS int) AS Engineer
	,CAST(u.User_Define_1 AS int) AS Est_hoursOT
	,CAST(u.User_Define_2 AS int) AS Est_manpower
	,CAST(u.User_Define_3 AS int) AS Foreman
	,CAST(u.User_Define_4 AS int) AS Projected_hours
	,CAST(u.USRDAT01 AS date) AS Date_Salesforce
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
		-- USRDAT01			::	SalesForce Booking Date
		-- User_Defined_CB_1	::	Permits Required
		-- User_Defined_CB_2	::	Priority Job

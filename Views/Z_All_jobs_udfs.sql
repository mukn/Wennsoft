--ALTER VIEW Z_All_jobs_udfs AS
-- UDF field values
SELECT 
	u.WS_Job_Number AS Job_number
	,u.WS_Manager_ID_2 AS Superintendent
	,u.WS_Engineer AS Engineer
	,u.User_Define_1 AS Est_hoursOT
	,u.User_Define_2 AS Est_manpower
	,u.User_Define_3 AS Foreman
	,u.User_Define_4 AS Projected_hours
	,u.USRDAT01 AS Date_Salesforce
	,u.User_Defined_CB_1 AS Permit_reqd
	,u.User_Defined_CB_2 AS Flag_priority
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

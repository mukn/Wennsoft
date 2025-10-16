/**		Z_All_appointments
	This is a view of all appointments.

*/
--CREATE VIEW Z_All_appointments AS
SELECT
	--TOP 100
	TRIM(a.Service_Call_ID) AS Work_number
	,TRIM(Appointment_Status) AS Appt_status
	,TRIM(a.Appointment) AS Appt_number
	,CAST(a.Appointment_Type AS int) AS Appt_type
	,TRIM(a.Appointment_Description) AS Appt_description
	,TRIM(a.Technician) AS Technician
	,CAST(a.WS_Cost_Code AS int) AS Cost_code
	,TRIM(a.WS_Job_Number) AS Job_number
	,CASE
		WHEN a.Task_Date > '1900-01-01' THEN CAST(a.Task_Date AS date)
	END AS Date_work
	,CAST(a.STRTTIME AS date) AS Date_start
	,CASE
		WHEN a.ENDTIME > '1900-01-01' THEN CAST(a.ENDTIME AS date)
	END AS Date_end
	,CASE
		WHEN a.Completion_Date > '1900-01-01' THEN CAST(a.Completion_Date as date)
	END AS Date_complete
	,CASE
		WHEN a.Estimate_Hours > 0 THEN (a.Estimate_Hours / 100.0) 
	END AS Hours_estimate
	,CASE
		WHEN a.Actual_Hours > 0 THEN (a.Actual_hours / 100.0) 
	END AS Hours_Actual
	,CASE
		WHEN a.CREATDDT > '1900-01-01' THEN CAST(a.CREATDDT AS date)
	END AS Date_create
	--,a.*
FROM
	SV00301 AS a		-- Appointment master

ORDER BY
	Completion_Date ASC,
	Task_Date DESC

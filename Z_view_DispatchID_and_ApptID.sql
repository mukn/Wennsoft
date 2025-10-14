-- ALTER VIEW Z_view_DispatchID_and_ApptID AS
SELECT 
	TRIM(Service_Call_ID) AS Work_number
	,TRIM(Appointment) AS Appt_number
	,Technician
	,TRIM(WS_Job_Number) AS Job_number
	,Appointment_Description AS Appt_description
	,CAST(Task_Date AS date) AS Date_created
	,CAST(ENDTIME AS date) AS Date_end
	,Estimate_Hours AS Hours_estimate
	,Actual_Hours AS Hours_actual
	,Appointment_Status AS Appt_status
	,CAST(Completion_Date AS date) AS Date_complete
	,DEX_ROW_ID AS Appt_ID
	--,*
FROM SV00301
--WHERE 
	-- Service_Call_ID = '251001-0036'

/**		Z_service_calls_w_dispatchid_1mo
	This is a list of the last month of work orders with the dispatchID. It 
	also captures items that are not complete or cancelled older than 30 
	days.

	*/
--ALTER VIEW Z_service_calls_w_dispatchid_1mo AS
SELECT
		--TOP 100
		TRIM(a.Service_Call_ID) AS WO_number
		,TRIM(a.Appointment) AS WO_appt
		,a.DEX_ROW_ID AS DispatchID
		,TRIM(a.Appointment_Group_ID) AS Appt_GrpID
		,TRIM(a.Appointment_Status) AS Appt_status
		,CAST(a.Task_Date AS date) AS Work_date
		,CAST(a.Completion_Date AS date) AS Complete_date
		,TRIM(a.Technician) AS Technician
		,CASE
			WHEN a.Estimate_Hours > 0 THEN (a.Estimate_Hours / 100) 
			ELSE 0
		END AS Hours_est
		,CASE
			WHEN a.Actual_Hours > 0 THEN (a.Actual_Hours / 100)
			ELSE 0
		END AS Hours_act
		--,a.*

	FROM
		SV00301 AS a

	WHERE
		a.Task_Date > GETDATE() - 30
		OR (a.Appointment_Status <> 'COMPLETE'
		AND a.Appointment_Status <> 'CANCELLED')

	--ORDER BY
	--	TRIM(a.Service_Call_ID) DESC,
	--	TRIM(a.Appointment) ASC,
	--	a.Task_Date DESC

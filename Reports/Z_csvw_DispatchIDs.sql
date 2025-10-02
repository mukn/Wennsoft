/** This is a report linking DispatchIDs to the history table that records changes to the DispatchID.
  This should eventually help match incoming GoCanvas time with WennSoft.
  */

SELECT
	*
FROM
	(
	/** Appointments & activities current */
	SELECT
		TOP 100
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

	ORDER BY
		TRIM(a.Service_Call_ID) DESC,
		TRIM(a.Appointment) ASC
	) AS a
	JOIN
	(
	/** Appointments & activities history */
	SELECT
		--TOP 1000
		TRIM(h.Service_Call_ID) AS WO_number
		,TRIM(h.Appointment) AS WO_appt
		,h.WS_Appointment_ID AS DispatchID
		,TRIM(h.Appointment_Action) AS Appt_action
		,TRIM(h.Appointment_Status) AS Appt_status
		,CAST(h.Task_Date AS date) AS Work_date
		,CAST(h.Completion_Date AS date) AS Complete_date
		,TRIM(h.Technician) AS Technician
		,CASE
			WHEN h.Estimate_Hours > 0 THEN (h.Estimate_Hours / 100) 
			ELSE 0
		END AS Hours_est
		,CASE
			WHEN h.Actual_Hours > 0 THEN (h.Actual_Hours / 100)
			ELSE 0
		END AS Hours_act
		--,h.*
	FROM
		SV30301 AS h
	--WHERE TRIM(h.Service_Call_ID) = '251001-0284'
	--ORDER BY
	--	h.Task_Date DESC
	) AS h
		ON a.DispatchID = h.DispatchID

	ORDER BY
		a.DispatchID DESC

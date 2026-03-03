/*
	-- Z_Service_call_appointment_actual_hours
	
	This captures each service call appointment, the actual labor hours,
	and the service technician who worked the appointment.
*/
--CREATE VIEW Z_Service_call_appointment_actual_hours AS
SELECT
	TRIM(apt.Service_Call_ID) AS Work_number,
	TRIM(apt.Appointment) AS Appt_number,
	TRIM(apt.Appointment_Description) AS Appt_description,
	TRIM(apt.Appointment_Status) AS Appt_status,
	emp.Employee_code,
	TRIM(apt.Technician) AS Technician_username,
	CAST(apt.Task_Date as date) AS Date_scheduled,
	CASE
		WHEN CAST(apt.Completion_Date AS date) > '1900-01-02'
		THEN CAST(apt.Completion_Date AS date)
		ELSE NULL
	END AS Date_complete,
	(apt.Actual_Hours / 100.) AS Hours_actual

	--,apt.*

FROM
	SV00301 AS apt
	LEFT OUTER JOIN
	Z_Employee_to_technician_map AS emp
		ON apt.Technician = emp.Technician_username
WHERE TRIM(apt.Service_Call_ID) <> ''
--ORDER BY TRIM(apt.Service_Call_ID) DESC

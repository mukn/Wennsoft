-- Open job appointments for Special Projects
SELECT
	TRIM(j.WS_Job_Number) AS Job_Number
	,TRIM(a.Appointment) AS Appt_Number
	,TRIM(a.Appointment_Status) AS Appt_Status
	,a.Task_Date AS Appt_Date
	,TRIM(a.Technician) AS Technician
	,TRIM(a.Appointment_Description) AS Appt_Description
	,TRIM(j.WS_Job_Name) AS Job_Name
	,TRIM(CUSTNMBR) AS Customer_Code
	,TRIM(Job_Address_Code) AS Location_Code
	--,j.*
	--,a.*
FROM
	JC00102 AS j
	JOIN
	SV00301 AS a
		ON j.WS_Job_Number = a.WS_Job_Number
WHERE
	j.Divisions LIKE '%_SP_%'
	AND Appointment_Status <> 'COMPLETE'
ORDER BY
	j.WS_Job_Number DESC, a.Appointment ASC

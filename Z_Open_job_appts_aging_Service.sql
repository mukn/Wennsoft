-- Open job appointments for Service
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
	,CAST((GETDATE() - a.Task_Date) AS int) AS Age
	,CASE
		WHEN CAST((GETDATE() - a.Task_Date) AS int) > 180
			THEN 180
		WHEN CAST((GETDATE() - a.Task_Date) AS int) > 90
			THEN 90
		WHEN CAST((GETDATE() - a.Task_Date) AS int) > 60
			THEN 60
		WHEN CAST((GETDATE() - a.Task_Date) AS int) > 45
			THEN 45
		ELSE 30
	END AS Aging_Bucket
	--,j.*
	--,a.*
FROM
	JC00102 AS j
	JOIN
	SV00301 AS a
		ON j.WS_Job_Number = a.WS_Job_Number
WHERE
	j.Divisions LIKE '%_HVAC_%'					-- Select only Service items
	AND Appointment_Status <> 'COMPLETE'		-- Select only appointments not marked complete
	AND (GETDATE() - a.Task_Date ) > 30			-- Select only appointments aged by 30 or more days
ORDER BY
	--j.WS_Job_Number DESC, a.Appointment ASC
	CAST((GETDATE() - a.Task_Date) AS int) DESC

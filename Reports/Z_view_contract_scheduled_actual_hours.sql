/**		Contract, scheduled, and actual hours
	This identifies all active contracts, extracts the hours as scheduled during
	contract entry, and compares that against the actual hours.

	14039 rows on 9 Oct 2025.

	*/
--ALTER VIEW Z_view_contract_scheduled_actual_hours AS
SELECT 
	TRIM(t.Contract_number) AS Contract_number
	--, TRIM(t.Task_Code) AS Task_code
	,TRIM(t.Equipment_ID) AS Equipment_code
	,CAST(t.Original_Schedule_Date AS date) AS Date_onContract
	,TRIM(t.Service_call_id) AS Work_number
	--,a.Work_number
	,CAST(t.Schedule_Date AS date) AS Date_scheduled
	,a.Appt_number
	,a.Date_ofWork
	,a.Appt_description
	,a.Appt_status
	,a.Date_complete
	,CASE WHEN (t.Estimate_Hours > 0) THEN (t.Estimate_Hours / 100.0) ELSE 0 END AS Hours_contractEstimate
	,a.Hours_estimate AS Appt_hours
	,a.Hours_actual AS Appt_actual
	--,t.Dex_row_id
	--,a.DEX_ROW_ID
FROM 
	SV00585 AS t WITH (NOLOCK) 
	LEFT JOIN
	(
		SELECT
			TRIM(a.Service_Call_ID) AS Work_number, TRIM(WS_Job_Number) AS Job_number, TRIM(a.Appointment) AS Appt_number, TRIM(a.Appointment_Description) AS Appt_description, TRIM(a.Appointment_Status) AS Appt_status,
			CAST(a.Task_Date AS date) AS Date_ofWork, CAST(a.Completion_Date AS date) AS Date_complete, (a.Estimate_Hours / 100.0) AS Hours_estimate, (a.Actual_Hours / 100.0) AS Hours_actual, a.DEX_ROW_ID--, *
		FROM
			SV00301 AS a WITH (NOLOCK)			-- 51140 rows
		WHERE
			TRIM(a.Service_Call_ID) <> ''		-- 32907 rows
	) AS a
		ON TRIM(t.Service_call_id) = a.Work_number

WHERE 
	t.Equipment_ID = 'HOURS'		-- 10526 rows
	--AND t.Contract_Number = '3900TUNL23'

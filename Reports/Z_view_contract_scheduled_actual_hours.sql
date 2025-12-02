/**		Contract, scheduled, and actual hours
	This identifies all active contracts, extracts the hours as scheduled during
	contract entry, and compares that against the actual hours.

	14043 rows on 9 Oct 2025.

	*/
--ALTER VIEW Z_view_contract_scheduled_actual_hours AS
SELECT
    TRIM(t.Contract_Number) AS Contract_number,
    CAST(t.Original_Schedule_Date AS DATE) AS [Visit Date],
    TRIM(t.Service_Call_ID) AS Work_number,
    CASE 
        WHEN (t.Estimate_Hours > 0) THEN (t.Estimate_Hours / 100.0)
        ELSE 0 
    END AS [Budget Hours],
    a_1.Hours_actual AS Appt_hours
FROM dbo.SV00585 AS t WITH (NOLOCK)
LEFT OUTER JOIN (
    SELECT 
        TRIM(Service_Call_ID) AS Work_number,
        TRIM(WS_Job_Number) AS Job_number,
        TRIM(Appointment) AS Appt_number,
        TRIM(Appointment_Description) AS Appt_description,
        TRIM(Appointment_Status) AS Appt_status,
        CAST(Task_Date AS DATE) AS Date_ofWork,
        CAST(Completion_Date AS DATE) AS Date_complete,
        Estimate_Hours / 100.0 AS Hours_estimate,
        Actual_Hours / 100.0 AS Hours_actual,
        DEX_ROW_ID
    FROM dbo.SV00301 AS a WITH (NOLOCK)
    WHERE TRIM(Service_Call_ID) <> ''
) AS a_1 ON TRIM(t.Service_Call_ID) = a_1.Work_number
LEFT OUTER JOIN (
    SELECT 
        TRIM(Service_Call_ID) AS Work_number,
        SUM(Actual_Hours / 100.0) AS Hours_actual
    FROM dbo.SV00301 AS a WITH (NOLOCK)
    WHERE TRIM(Service_Call_ID) <> ''
    GROUP BY Service_Call_ID
) AS s ON a_1.Work_number = s.Work_number
WHERE t.Equipment_ID = 'HOURS';

/**		Contract, scheduled, and actual hours
	This identifies all active contracts, extracts the hours as scheduled during
	contract entry, and compares that against the actual hours.

	14043 rows on 9 Oct 2025.

	*/
--ALTER VIEW Z_view_contract_scheduled_actual_hours AS
SELECT
    TRIM(t.Contract_Number) AS Contract_number,
    CAST(t.Original_Schedule_Date AS DATE) AS [Visit Date],
    --TRIM(t.Service_Call_ID) AS Work_number,
	s.Work_Number,
    CASE 
        WHEN (t.Estimate_Hours > 0) THEN (t.Estimate_Hours / 100.0)
        ELSE 0 
    END AS [Budget Hours],
    h.Hours_actual AS Appt_hours
FROM
	(SELECT 
		TRIM(Service_Call_ID) AS Work_number
		FROM dbo.SV00301 AS a WITH (NOLOCK)
	WHERE TRIM(Service_Call_ID) <> ''
	GROUP BY Service_Call_ID
		) AS s
	LEFT OUTER JOIN
		SV00585 AS t ON TRIM(t.Service_Call_ID) = s.Work_number
	LEFT OUTER JOIN
		(SELECT TRIM(WS_Job_Number) AS Work_number,SUM(TRXHRUNT / 100.) AS Hours_actual--,'',*
			FROM WS30702 GROUP BY WS_Job_Number
		) AS h ON TRIM(t.Service_Call_ID) = h.Work_number
WHERE t.Equipment_ID = 'HOURS'

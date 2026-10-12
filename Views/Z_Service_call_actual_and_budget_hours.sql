/*    Z_Service_call_actual_and_budget_hours
    This is a collection of both service calls, the actual hours for the call,
    and the budgeted hours for the call.

*/

--ALTER VIEW Z_Service_call_actual_and_budget_hours AS
SELECT        
	TRIM(a.Service_Call_ID) AS Work_number,
	--TRIM(a.Appointment_Status) AS Work_status,
	TRIM(a.Appointment) AS Appt_number,
	SUM(a.Actual_Hours / 100.) AS Actual_hours, 
	SUM(a.Estimate_Hours / 100.) AS Appointment_hours,
	(t.Estimate_Hours / 100.) AS Task_hours

FROM
	dbo.SV00301 AS a WITH (NOLOCK)
	LEFT OUTER JOIN
	dbo.SV00302 AS t WITH (NOLOCK)
		ON a.Service_Call_ID = t.Service_Call_ID
WHERE
	(TRIM(a.Service_Call_ID) <> '')
	AND Appointment_Status <> 'COMPLETE'
	--AND a.Service_Call_ID = '261001-0098'
	AND t.Equipment_ID = 'HOURS'
GROUP BY a.Service_Call_ID, Appointment, t.Estimate_Hours
--ORDER BY Work_number DESC

/*    Z_Service_call_actual_and_budget_hours
    This is a collection of both service calls, the actual hours for the call,
    and the budgeted hours for the call.

*/

--ALTER VIEW Z_Service_call_actual_and_budget_hours AS
SELECT 
	TRIM(a.Service_Call_ID) AS Work_number,
	--TRIM(a.Appointment_Status) AS Work_status,
	SUM(a.Actual_hours / 100.) AS Actual_hours,
	SUM(a.Estimate_Hours / 100.) AS Budget_hours
	FROM SV00301 AS a WITH (NOLOCK)
WHERE TRIM(a.Service_Call_ID) <> ''
GROUP BY a.Service_Call_ID
--ORDER BY Work_number DESC

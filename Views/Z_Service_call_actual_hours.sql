/* 
	SV00301 contains all service calls and their status.
	We're excluding those scheduled visits that do not have a service call created.
*/
--CREATE VIEW Z_Service_call_actual_hours AS
SELECT 
	TRIM(a.Service_Call_ID) AS Work_number, TRIM(a.Appointment_Status) AS Work_status, SUM(a.Actual_hours / 100.) AS Actual_hours
	FROM SV00301 AS a WITH (NOLOCK)
WHERE TRIM(a.Service_Call_ID) <> ''
GROUP BY a.Service_Call_ID, a.Appointment_Status
ORDER BY Work_number DESC

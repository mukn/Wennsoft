/**		Contract, scheduled, and actual hours
	This identifies all active contracts, extracts the hours as scheduled during
	contract entry, and compares that against the actual hours.

	9510 rows on 26 Feb 2026.

	References:
		- Z_Contract_service_calls_active - A collection of all active contract service calls
		- Z_Service_call_budget_hours - A collection of contract service calls with the budget labor hours
		- Z_Service_call_actual_hours - A collection of contract service calls with the actual labor hours

	*/
--ALTER VIEW Z_view_contract_scheduled_actual_hours AS
SELECT
	m.Customer_code,
	m.Location_code,
	m.Contract_code,
	m.Scheduled_date AS [Visit Date],
	a.Work_number AS Work_Number,
	b.Call_status AS Work_status,		-- Needs to be retrieved from SV00300.Status_of_call
	b.Budget_hours AS [Budget Hours],
	a.Actual_hours AS Appt_hours
	--,b.*
FROM
	Z_Contract_service_calls_active AS m
	LEFT OUTER JOIN
	Z_Service_call_budget_hours AS b
		ON m.Work_number = b.Work_number
	LEFT OUTER JOIN
	Z_Service_call_actual_hours AS a
		ON m.Work_number = a.Work_number
--ORDER BY m.Work_number DESC

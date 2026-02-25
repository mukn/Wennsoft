/*
	SV00581 contains tasks per service calls. This is isolated to
	look at HOURS to retrieve the budget hours per service call.
*/
--ALTER VIEW Z_Service_call_budget_hours AS
SELECT
	TRIM(CUSTNMBR) AS Customer_code,
	TRIM(ADRSCODE) AS Location_code,
	TRIM(Service_Call_ID) AS Work_number,
	TRIM(Task_Status) AS Call_status,
	CASE
		WHEN Completion_Date > '1900-01-02' THEN CAST(Completion_Date AS date)
		ELSE NULL
	END AS Complete_Date,
	(Estimate_Hours / 100.) AS Budget_hours
	FROM SV00302
WHERE Equipment_ID = 'HOURS'
--ORDER BY Work_number DESC

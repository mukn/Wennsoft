/*
	SV00585 captures contracts and the active service calls against them.
	We include scheduled date and estimated hours.
	*/
--ALTER VIEW Z_Contract_service_calls_active AS
SELECT
	--TOP 10
	TRIM(CUSTNMBR) AS Customer_code,
	TRIM(ADRSCODE) AS Location_code,
	TRIM(Contract_Number) AS Contract_code,
	TRIM(Service_Call_ID) AS Work_number,
	CAST(Original_Schedule_Date AS DATE) AS Scheduled_date,
	(Estimate_Hours / 100.) AS Estimate_hours
	--,*
FROM SV00585
WHERE Equipment_ID = 'HOURS'
ORDER BY Service_Call_ID DESC

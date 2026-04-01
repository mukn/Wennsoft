/**		Z_view_service_contract_schedule_hours_byMonth

	This captures the monthly estimated hours for each contract. Each
	row represents one year (from start date) of the contract. A one-
	year contract starting June 2025 may list hours each month, but the 
	Jan through May values will be for 2026.

	SELECT * FROM Z_view_Service_contract_schedule_hours_byMonth

	*/
-- ALTER VIEW Z_view_service_contract_schedule_hours_byMonth AS
SELECT
	-- TOP 100
	TRIM(s.CUSTNMBR) AS Customer_code,
	TRIM(s.ADRSCODE) AS Location_code,
	TRIM(s.Contract_Number) AS Contract_code,
	s.Contract_Year AS Contract_year,
	s.Schedule_Date,
	(s.Estimate_Hours / 100.) AS Estimate_hours
	--,s.*

FROM
	SV00585 AS s		-- SV_Contract_Schedule_View (Dynamic table)

WHERE
	Equipment_ID = 'HOURS'

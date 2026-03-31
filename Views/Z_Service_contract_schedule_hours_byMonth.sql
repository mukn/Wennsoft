/**		Z_Service_contract_schedule_hours_byMonth

	This captures the monthly estimated hours for each contract. Each
	row represents one year (from start date) of the contract. A one-
	year contract starting June 2025 may list hours each month, but the 
	Jan through May values will be for 2026.

	*/
-- CREATE VIEW Z_Service_contract_schedule_hours_byMonth AS
SELECT
	-- TOP 100
	TRIM(CUSTNMBR) AS Customer_code,
	TRIM(ADRSCODE) AS Location_code,
	TRIM(Contract_Number) AS Contract_code,
	Contract_Year,
	(Jan_Est_Hours / 100.) AS Jan_hrs,
	(Feb_Est_Hours / 100.) AS Feb_hrs,
	(March_Est_Hours / 100.) AS Mar_hrs,
	(April_Est_Hours / 100.) AS Apr_hrs,
	(May_Est_Hours / 100.) AS May_hrs,
	(June_Est_Hours / 100.) AS Jun_hrs,
	(July_Est_Hours / 100.) AS Jul_hrs,
	(Aug_Est_Hours / 100.) AS Aug_hrs,
	(Sept_Est_Hours / 100.) AS Sep_hrs,
	(Oct_Est_Hours / 100.) AS Oct_hrs,
	(Nov_Est_Hours / 100.) AS Nov_hrs,
	(Dec_Est_Hours / 100.) AS Dec_hrs
	--,*

FROM
	SV99585		-- SV_Contract_Schedule_View (Dynamic table)

WHERE 
	Equipment_ID = 'HOURS'

SELECT
	TRIM(w.Service_Call_ID) AS WO_Number
	,w.Resolution_ID
	,w.Status_of_Call AS WO_Status
	-- Division information and contacts
	,TRIM(w.Divisions) AS Division_Code
	,CASE
		WHEN w.Divisions LIKE '%_HVAC_%' THEN 'Service'
		WHEN w.Divisions LIKE '%_SP_%' THEN 'Special Projects'
	END AS Division_Name
	,CASE
		WHEN w.Divisions LIKE '%_HVAC_%' THEN 'dispatch@nacgroup.com'
		WHEN w.Divisions LIKE '%_SP_%' THEN 'special-projects@nacgroup.com'
		ELSE NULL
	END AS Division_email
	,w.Service_Area
	-- Sales rep information and contact

	-- Site information and contact
	,TRIM(w.ADRSCODE) AS Location_Code
	,TRIM(w.Caller_Name) AS Location_ContactName
	,TRIM(w.Caller_Email_Address) AS Location_ContactEmail
	,TRIM(w.Caller_Phone) AS Location_ContactPhone
	,*
FROM
	SV00300 AS w

WHERE
	TRIM(w.Status_of_Call) = 'Open'

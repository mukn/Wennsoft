SELECT
	-- Customer information
	TRIM(CUSTNMBR) AS Customer_Code

	-- Customer contact information
	,NULL AS Customer_ContactName

	-- Location information
	,TRIM(ADRSCODE) AS Location_Code
	,NULL AS Location_Name
	,NULL AS Location_Address1
	,NULL AS Location_Address2
	,NULL AS Location_City
	,NULL AS Location_State
	,NULL AS Location_Zip

	-- Location contact information
	,NULL AS Location_ContactName


	-- Contract information
	,TRIM(Contract_Number) AS Contract_Number
	,NULL AS Contract_StartDate
	,NULL AS Contract_EndDate
	,NULL AS Contract_VisitCnt
	,NULL AS Contract_Value

	-- Technician information
	,TRIM(Technician_ID) AS Tech_ID
	,NULL AS Tech_Name
	,NULL AS Tech_Email

	-- Sales rep information
	,TRIM(SLPRSNID) AS SalesRep_Code
	,NULL AS SalesRep_Name
	,NULL AS SalesRep_Email
	--,*
FROM
	SV00500 AS c

-- Active contracts
SELECT
	-- Customer information
	TRIM(c.CUSTNMBR) AS Customer_Code
	

	-- Customer contact information
	,NULL AS Customer_ContactName

	-- Location information
	,TRIM(c.ADRSCODE) AS Location_Code
	,NULL AS Location_Name
	,NULL AS Location_Address1
	,NULL AS Location_Address2
	,NULL AS Location_City
	,NULL AS Location_State
	,NULL AS Location_Zip

	-- Location contact information
	,NULL AS Location_ContactName


	-- Contract information
	,TRIM(c.Contract_Number) AS Contract_Number
	,CONVERT(date, c.Contract_Start_Date) AS Contract_StartDate
	,CONVERT(date, c.Contract_Expiration_Date) AS Contract_EndDate
	,NULL AS Contract_VisitCnt
	,c.Contract_Amount AS Contract_Value

	-- Technician information
	,TRIM(c.Technician_ID) AS Tech_ID
	,NULL AS Tech_Name
	,NULL AS Tech_Email

	-- Sales rep information
	,TRIM(c.SLPRSNID) AS SalesRep_Code
	,NULL AS SalesRep_Name
	,NULL AS SalesRep_Email
	,cust.*
FROM
	SV00500 AS c
	LEFT JOIN
	Z_Active_customers AS cust
		ON TRIM(c.CUSTNMBR) = cust.Customer_Code
	--LEFT JOIN
	--SV00300 AS v
	--	ON TRIM(c.Contract_Number) = TRIM(v.Contract_Number)


SELECT * FROM SV00500
SELECT TRIM(Contract_Number) AS CNum,* FROM SV00300 WHERE Contract_Number <> '' ORDER BY TRIM(Contract_Number) -- 2380, includes T&M plus MCC
SELECT * FROM SV00300 WHERE Type_Call_Short = 'MC' -- 275

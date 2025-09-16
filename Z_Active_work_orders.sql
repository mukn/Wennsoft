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
	,CASE
		WHEN w.Service_Area = '' THEN NULL
		ELSE w.Service_Area
	END AS Service_Area
	-- Sales rep information and contact
	,CASE
		WHEN TRIM(c.SLPRSNID) = '' THEN NULL
		ELSE TRIM(c.SLPRSNID) 
	END AS SalesRep_Code
	-- Site information and contact
	,TRIM(l.ADDRESS1) AS Job_Address1
	--,TRIM(l.Address2) AS Job_Address2
	,TRIM(l.CITY) AS Job_City
	,TRIM(l.STATE) AS Job_State
	,TRIM(l.ZIP) AS Job_Zip
	,CASE
		WHEN w.Caller_Name = '' THEN NULL
		ELSE TRIM(w.Caller_Name)
	END AS Location_ContactName
	,CASE
		WHEN w.Caller_Email_Address = '' THEN NULL
		ELSE TRIM(w.Caller_Email_Address)
	END AS Location_ContactEmail
	,CASE
		WHEN LEN(TRIM(w.Caller_Phone)) > 10 AND RIGHT(TRIM(w.Caller_Phone), 4) > 1
			THEN CONCAT(LEFT(w.Caller_Phone, 10), ';', RIGHT(TRIM(w.Caller_Phone), 4))
		WHEN LEN(TRIM(w.Caller_Phone)) > 10 AND RIGHT(TRIM(w.Caller_Phone), 4) = 0
			THEN LEFT(TRIM(w.Caller_Phone), 10)
		WHEN LEN(TRIM(w.Caller_Phone)) = 10
			THEN TRIM(w.Caller_Phone)
		ELSE NULL
	END AS Location_ContactPhone
	--,LEFT(w.Caller_Phone, 10) AS Location_ContactPhone
	--,RIGHT(TRIM(w.Caller_Phone), 4) AS Location_ContactPhoneExt
	-- Work order information
	,TRIM(w.Service_Description) AS WO_Name
	,CASE 
		WHEN TRIM(w.Technician_ID) = '' THEN NULL
		ELSE TRIM(w.Technician_ID)
	END AS Tech_ID
	,NULL AS Tech_Name
	,NULL AS Tech_Email
	,w.Purchase_Order AS Customer_PO
	,TRIM(w.Bill_Customer_Number) AS Customer_Code									-- For matching against locations
	,TRIM(w.ADRSCODE) AS Location_Code												-- For matching against locations
	,CASE																			-- For matching against contracts
		WHEN TRIM(w.Contract_Number) = '' THEN NULL
		ELSE TRIM(w.Contract_Number)
	END AS Contract_Number
	--,*
FROM
	SV00300 AS w
	JOIN
	SV00200 AS l
		ON TRIM(w.Bill_Customer_Number) = TRIM(L.CUSTNMBR) 
		AND TRIM(w.ADRSCODE) = TRIM(L.ADRSCODE)
	LEFT JOIN
	SV00500 AS c
		ON TRIM(w.Contract_Number) = TRIM(c.Contract_Number)
		--AND TRIM(w.Bill_Customer_Number) = TRIM(c.CUSTNMBR)


WHERE
	TRIM(w.Status_of_Call) = 'Open'


--SELECT * FROM SV00500
--SELECT * FROM UPR00100
--SELECT distinct(JOBTITLE) AS Job_Code,FIRST_VALUE(CONCAT(TRIM(FRSTNAME), ' ', TRIM(LASTNAME))) over(partition by JOBTITLE order by CAST(EMPLOYID AS int)) AS Empl_Name FROM UPR00100

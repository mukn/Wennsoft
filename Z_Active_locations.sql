SELECT 
    TRIM(CUSTNMBR) AS Customer_code, 
    TRIM(CUSTNAME) AS Customer_name, 
    TRIM(ADRSCODE) AS Location_code, 
    TRIM(LOCATNNM) AS Location_name, 
    TRIM(ADDRESS1) AS Location_Address1, 
    '' AS Location_Address2, 
    TRIM(CITY) AS Location_city, 
    TRIM(STATE) AS Location_state, 
    TRIM(ZIP) AS Location_ZIP, 
    TRIM(SLPRSNID) AS SalesRep_code, 
    '' AS SalesRep_email, 
    SUBSTRING(PHONE1, 1, 10) AS Site_Phone1, 
    SUBSTRING(PHONE2, 1, 10) AS Site_Phone2, 
    '' AS Special_instructions,
	CASE
		WHEN c.Contract_Number IS NOT NULL THEN 'Contract'
		ELSE 'Non-contract'
	END AS Contract_flag
FROM 
    SV00200 AS l
	LEFT OUTER JOIN
	Z_Active_service_contracts AS c
		ON TRIM(l.CUSTNMBR) = c.Customer_Code
		AND TRIM(ADRSCODE) = c.Location_Code

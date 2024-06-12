-- Customers
SELECT 
	TRIM(c.CUSTNMBR) AS Customer_Code
	,TRIM(l.CUSTNAME) AS Customer_Name
	,TRIM(l.ADDRESS1) AS Customer_Address1
	,TRIM(l.CITY) AS Customer_City
	,TRIM(l.STATE) AS Customer_State
	,TRIM(l.ZIP) AS Customer_Zip
	,CASE
		WHEN TRIM(l.PHONE1) = '' THEN NULL
		ELSE TRIM(l.PHONE1)
	END AS Customer_Phone1
	,CASE
		WHEN TRIM(l.FAX) = '' THEN NULL
		ELSE TRIM(l.FAX)
	END AS Customer_Fax
	,CASE
		WHEN TRIM(l.CNTCPRSN) = '' THEN NULL
		ELSE TRIM(l.CNTCPRSN)
	END AS Customer_Contact
	,CASE
		WHEN l.WS_Latitude > 24 AND l.WS_Latitude < 51 THEN l.WS_Latitude
		ELSE NULL
	END AS Customer_Latitude_North
	,CASE
		WHEN l.WS_Longitude > 69 AND l.WS_Longitude < 126 THEN l.WS_Longitude
		ELSE NULL
	END AS Customer_Longitude_West
	
	--,* 
FROM
	SV00100 as c
	LEFT JOIN
	SV00200 AS l
		ON TRIM(c.CUSTNMBR) = TRIM(l.CUSTNMBR)
WHERE TRIM(l.ADRSCODE) = 'MAIN'

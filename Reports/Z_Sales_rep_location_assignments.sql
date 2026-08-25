--CREATE VIEW Z_Sales_rep_location_assignments AS
SELECT
	TRIM(l.Custnmbr) AS Customer_code
	,TRIM(l.Custname) AS Customer_name
	,TRIM(l.ADRSCODE) AS Location_code
	,TRIM(l.LOCATNNM) AS Location_name
	,TRIM(l.SLPRSNID) AS SalesRep_code
	,CASE
		WHEN SalesRep_code <> '' THEN CONCAT(s.Employee_lastName, ', ', s.Employee_firstName)
		ELSE NULL
	END AS SalesRep
	,TRIM(l.Labor_Group_name) AS Contract_flag
	,l.User_Define_1a AS Vertical_market
	,l.WS_Latitude AS Latitude
	,l.WS_Longitude AS Longitude
	--,*

FROM
	SV00200 AS l
	LEFT JOIN
	Z_Employee_to_salesRep AS s
		ON l.SLPRSNID = s.SalesRep_code

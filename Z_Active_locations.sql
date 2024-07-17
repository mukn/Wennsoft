/** This pulls a list of all active locations. **/
SELECT
	TRIM(L.ADRSCODE) AS Location_Code
	,TRIM(L.LOCATNNM) AS Location_Name
	,TRIM(L.ADDRESS1) AS Location_Address1
	,TRIM(L.CITY) AS Location_City
	,TRIM(L.STATE) AS Location_State
	,TRIM(L.ZIP) AS Location_ZIP
	,TRIM(L.SLPRSNID) AS Sales_Rep
	,TRIM(L.CUSTNMBR) AS Customer_Code
	,TRIM(L.CUSTNAME) AS Customer_Name
	--,*
FROM SV00200 AS L

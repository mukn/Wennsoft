--CREATE VIEW Z_Employee_to_salesRep AS
SELECT 
	CAST(EMPLOYID AS int) AS Employee_code
	,TRIM(SLPRSNFN) AS Employee_firstName
	,TRIM(SPRSNSLN) AS Employee_lastName
	,TRIM(SLPRSNID) AS SalesRep_code
	,Phone1 AS Employee_phone
	,CAST(INACTIVE AS int) AS Flag_inactive
	--,*
FROM
	RM00301

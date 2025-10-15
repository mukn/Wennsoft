/**		Z_Service_contract_revenue_schedule
	
	This is a list of scheduled revenue for contracts. Retrieved from the
	Revenue Schedule card in WennSoft.

*/
--CREATE VIEW Z_Service_contract_revenue_schedule AS 
SELECT
	--TOP 1000
	TRIM(r.CUSTNMBR) AS Customer_code
	,TRIM(r.ADRSCODE) AS Location_code
	,TRIM(r.Contract_Number) AS Contract_number
	,CASE
		WHEN r.YEAR1 > 0 THEN r.YEAR1
	END AS Year_billed
	,CASE
		WHEN r.PERIODID > 0 THEN r.PERIODID
	END AS Period_billed
	,r.DOCAMNT AS Document_amount
	,CASE
		WHEN r.DATE1 > '1900-01-01' THEN CAST(r.DATE1 AS date)
	END AS Date_bill
	,CASE
		WHEN r.POSTDATE > '1900-01-01' THEN CAST(r.POSTDATE AS date)
	END AS Date_posted
	
	--,r.*
FROM
	SV00509 AS r			-- SV_Contract_revenue_method2_MSTR

--WHERE
--	r.Contract_Number = '600PENNS23'

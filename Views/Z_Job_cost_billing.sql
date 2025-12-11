/**		-- Job billing --		*/
--CREATE VIEW Z_Job_cost_billing AS
SELECT --TOP 10
	TRIM(WS_Job_Number) AS Job_number
	,TRIM(Docnumbr) AS Document_number
	,CAST(DOCDATE AS date) AS Document_date
	,TRIM(CUSTNMBR) AS Customer_code
	,DOCAMNT AS Document_amount
	--,* 

FROM JC20501

ORDER BY Document_date

-- CREATE VIEW Z_Service_costs AS
SELECT
	--TOP 100
	TRIM(s.VENDORID) AS Vendor_code,
	TRIM(s.Service_Call_ID) AS Work_number,
	TRIM(s.Call_Invoice_Number) AS Invoice_number,
	s.JRNENTRY AS Journal_number,
	CAST(s.WS_Cost_Code AS int) AS Cost_code,
	TRIM(s.WS_Cost_Code_STR) AS Cost_label,
	CAST(s.DOCTYPE AS int) AS Document_code,
	CAST(s.DOCDATE AS date) AS Document_date,
	CAST(s.DOCAMNT AS float) AS Document_amount
	
	--,s.*

FROM
	SV_Costs AS s

WHERE
	(s.WS_Cost_Code_STR = 'MATERIAL' OR
	s.WS_Cost_Code_STR = 'EQUIPMENT')
	--AND s.DOCDATE > GETDATE() - 365
	AND DOCAMNT <> 0

--ORDER BY s.DOCDATE ASC

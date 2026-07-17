-- CREATE VIEW Z_Job_costs AS
SELECT 
	--TOP 100
	TRIM(j.VENDORID) AS Vendor_code,
	TRIM(j.WS_Job_Number) AS Work_number,
	'' AS Invoice_number,
	j.JRNENTRY AS Journal_number,
	CAST(j.Cost_Element AS int) AS Cost_code,
	TRIM(j.Cost_Code_Description) AS Cost_label,
	CAST(j.DOCTYPE AS int) AS Document_code,
	CAST(j.DOCDATE AS date) AS Document_date,
	CAST(j.DOCAMNT AS float) AS Document_amount
	--,j.* 
	
FROM 
	JC20001 AS j		-- Job cost costs

WHERE
	(j.Cost_Code_Description = 'Materials' OR
	j.Cost_Element = 1)
	--AND j.DOCDATE > GETDATE() - 365
	AND DOCAMNT <> 0

--ORDER BY j.DOCDATE ASC

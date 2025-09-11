--ALTER VIEW Z_All_work_orders_finance AS
SELECT
	wo.WO_number,
	wo.Division,
	wo.Date_of_Service_Call,
	wo.Month_bucket,
	wo.Year_bucket,
	c.Trx_number,
	c.Anticipated_billable,
	c.Actual_cost,
	c.Cost_code,
	c.Cost_Code_Description,
	c.TRXSOURC
	--,wo.*
FROM
	Z_All_work_orders AS wo
	LEFT OUTER JOIN
	(SELECT TRIM(Service_Call_ID) AS WO_number, TRIM(Reference_TRX_Number) AS Trx_number, Billing_Amount AS Anticipated_billable,
		WS_Extended_Cost AS Actual_cost, CASE WHEN Cost_Code_Description <> '' THEN Cost_Code_Description WHEN TRXSOURC LIKE 'Purch%' THEN 'Material' END AS Cost_code, 
		Cost_Code_Description, TRXSOURC
		--,*
	FROM SV000810) AS c
		ON wo.WO_number = c.WO_number

--ORDER BY wo.Date_of_Service_Call DESC

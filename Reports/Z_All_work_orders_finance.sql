SELECT
	wo.WO_number AS WorkOrderNumber,
	wo.Division,
	wo.Date_of_Service_Call,
	wo.Month_bucket,
	wo.Year_bucket,
	c.Trx_number AS TransactionNumber,
	c.Anticipated_billable AS AnticipatedBillable,
	c.Actual_cost AS ActualCost,
	c.Cost_code AS CostCode,
	c.Cost_Code_Description AS CostCodeDescription,
	c.TRXSOURC AS TransactionSource
FROM 
	dbo.Z_All_work_orders AS wo
	LEFT OUTER JOIN (
	SELECT 
		TRIM(Service_Call_ID) AS WO_number,
		TRIM(Reference_TRX_Number) AS Trx_number,
		Billing_Amount AS Anticipated_billable,
		WS_Extended_Cost AS Actual_cost,
		CASE 
			WHEN Cost_Code_Description <> '' THEN Cost_Code_Description
			WHEN TRXSOURC LIKE 'Purch%' THEN 'Material'
		END AS Cost_code,
		Cost_Code_Description,
		TRXSOURC
	FROM SV000810
	) AS c 
		ON wo.WO_number = c.WO_number

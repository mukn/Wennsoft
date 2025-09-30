SELECT
	TRIM(wo.Service_Call_ID) AS WO_number,
	TRIM(wo.CUSTNMBR) AS Customer_code,
	TRIM(wo.Bill_Address_Code) AS Customer_billcode,
	TRIM(wo.ADRSCODE) AS Location_code,
	TRIM(wo.Contact_ID) AS Contact_code,
	TRIM(wo.Divisions) AS Division,
	TRIM(wo.Contract_Number) AS Contract_number,
	TRIM(wo.Service_Description) AS WO_description,
	TRIM(wo.Technician) AS Technician_code,
	wo.Technician_ID,
	wo.Technician_ID2,
	wo.Technician_Team,
	wo.Service_Area,
	wo.Type_Call_Short,
	wo.Resolution_ID,
	wo.Purchase_Order,
	wo.Date_of_Service_Call,
	MONTH(wo.Date_of_Service_Call) AS Month_bucket,
	YEAR(wo.Date_of_Service_Call) AS Year_bucket,
	wo.Completion_Date,
	wo.WS_Time_1,
	wo.DATE1,
	h.Hours_estimate,
	h.Hours_actual,
	TRIM(wo.Status_of_Call) AS Status,
	wo.User_Define_1a,
	wo.User_Define_2a
FROM
	SV00300 AS wo
	LEFT OUTER JOIN (
	SELECT 
		TRIM(Service_Call_ID) AS WO_number,
		SUM(Estimate_Hours) / 100.0 AS Hours_estimate,
		SUM(Actual_Hours) / 100.0 AS Hours_actual
	FROM SV00301
	GROUP BY Service_Call_ID
	) AS h 
		ON TRIM(wo.Service_Call_ID) = h.WO_number

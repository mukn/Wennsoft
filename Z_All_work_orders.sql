--ALTER VIEW Z_All_work_orders AS

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
	wo.Date1,
	est.Hours_estimate,
	act.Hours_actual,
	
	TRIM(wo.Status_of_Call) AS Status,
	wo.User_Define_1a,
	wo.User_Define_2a
	--,wo.*
FROM
	SV00300 AS wo
	LEFT JOIN
	(SELECT Service_Call_ID, Actual_Hours AS Hours_actual FROM csvw_SCID_ActualHoursSUM) AS act
		ON wo.Service_Call_ID = act.Service_Call_ID
	LEFT JOIN
	(SELECT Service_Call_ID, Estimated_Hours AS Hours_estimate FROM csvw_SCID_EstHoursSUM) AS est
		ON wo.Service_Call_ID = est.Service_Call_ID

ORDER BY wo.Date_of_Service_Call DESC


/**		Z_sv_Service_contract_maintenance
	
	This is a collection of top level financial data for 
	service contracts. Created from the Service contract
	maintenance SmartView in WennSoft.

*/

--ALTER VIEW Z_sv_Service_contract_maintenance AS
SELECT
	--TOP 1000
	TRIM(c.CUSTNMBR) AS Customer_code
	,TRIM(c.ADRSCODE) AS Location_code
	,TRIM(c.Contract_Number) AS Contract_number
	,c.Contract_Description
	--,CASE
	--	WHEN c.Divisions LIKE '%HVAC%' THEN 'Service'
	--	WHEN c.Divisions LIKE '%SP%' THEN 'Special Projects'
	--	ELSE ''
	--END AS Division
	,c.Contract_Amount
	,CASE
		WHEN LOWER(c.User_Define_1a) LIKE 'n%' THEN 'No'
		WHEN LOWER(c.User_Define_1a) LIKE 'y%' THEN 'Yes'
		ELSE ''
	END AS MaterialsIncl_Flag
	,c.Bill_Freq
	,CASE
		WHEN c.WSContractRenewalValue <> c.Contract_Amount THEN c.WSContractRenewalValue
	END AS Contract_renewal
	,c.Amount_Billed
	,c.Annual_Contract_Value
	,CAST(c.Contract_Start_Date AS date) AS Date_start
	,CAST(c.Contract_Expiration_Date AS date) AS Date_end
	-- Forecast original values
	,c.Forecast_Original_Labor
	,((c.Forecast_Orig_Labor1_Hrs + c.Forecast_Orig_Labor3_Hrs + c.Forecast_Orig_Labor4_Hrs + c.Forecast_Orig_Labor5_Hrs) / 100.0) 
		AS Forecast_Original_Hours
	,'Not available' AS Forecast_Original_Material
	,c.Forecast_Original_Equip
	,c.Forecast_Original_Subs
	,c.Forecast_Original_Other
	,'Not available' AS Forecast_Original_Total
	-- Forecast values
	,c.Forecast_Labor
	,((c.Forecast_Labor_1_Hours + c.Forecast_Labor_2_Hours + c.Forecast_Labor_3_Hours + c.Forecast_Labor_4_Hours + c.Forecast_Labor_5_Hours) / 100.0)
		AS Forecast_Hours
	,c.Forecast_Material
	,c.Forecast_Equipment
	,c.Forecast_Subs
	,c.Forecast_Other
	,c.Forecast_Total_Cost
	-- Estimate values
	,c.Estimate_Labor
	,((c.Estimate_Labor_1_Hours + c.Estimate_Labor_2_Hours + c.Estimate_Labor_3_Hours + c.Estimate_Labor_4_Hours + c.Estimate_Labor_5_Hours) / 100)
		AS Estimate_Hours
	,c.Estimate_Material
	,c.Estimate_Equipment
	,c.Estimate_Subs
	,c.Estimate_Other
	,c.Estimate_Total_Cost
	-- Actual values
	,c.Actual_Labor
	,c.Actual_Hours / 100.0
		AS Actual_hours
	,c.Actual_Material
	,c.Actual_Equipment
	,c.Actual_Subs
	,c.Actual_Other
	,c.Actual_Total_Cost
	,c.Actual_Contract_Earned
	,c.Actual_Gross_Profit
	,c.Actua_Revenue_Recognized
	,c.Actual_Billed
	,c.Contract_Billing_Date
	,c.Contract_Service_Date
	-- YTD amounts
	,c.YTD_Labor
	,c.YTD_Material
	,c.YTD_Equipment
	,c.YTD_Subcontractor
	,c.YTD_Other
	,c.YTD_Total_Cost
	,c.YTD_Billed
	,c.YTD_Contract_Earned
	,c.YTD_Gross_Profit
	,c.YTD_Revenue_Recognized
	,CASE
		WHEN c.Cancel_Box > 0 THEN 'Cancelled'
	END AS Cancelled
	,CASE
		WHEN c.HOLD > 0 THEN 'Hold'
	END AS Hold
	--,c.*

FROM
	SV00500 AS c			-- SV_Maint_MSTR

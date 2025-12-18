/**    Dataset_jobsAllJobsReport
    This is a cleaned version of csvw_all_jobs_masterv2 for
    publishing to Fabric.

*/
--ALTER VIEW Dataset_jobsAllJobsReport AS
SELECT
    TRIM(j.WS_Job_Number) AS Job_number,
    TRIM(j.WS_Job_Name) AS Job_name,
    TRIM(j.User_Define_1) AS Job_description,
    CASE
		WHEN j.Divisions LIKE '%_SP_%' THEN 'Special Projects'
		WHEN j.Divisions LIKE '%_HVAC_%' THEN 'Service'
		ELSE NULL
	END AS Division,
	--j.Divisions,
    TRIM(j.Job_Address_Code) AS Location_code,
    TRIM(j.Bill_Customer_Number) AS Customer_code,
    CAST(j.Estimator_ID AS int) AS Salesman_ID,
    j.Expected_Contract AS Expected_contract,
    CAST(j.Calc_Pct_Compl_to_Date AS int) AS Percent_complete,
    j.Est_Equipment_Cost AS Est_equipment,
    j.Est_Material_Cost AS Est_material,
    j.Est_Cost_UserDef1 AS Est_subs,
    j.Est_Labor_Cost AS Est_labor,
    j.Est_Misc_Other_Cost AS Est_misc,
    j.Est_Cost_UserDef2 AS Est_burden,
    j.Est_Cost_UserDef3 AS Contingency,
    j.Total_Estimated_Cost AS Total_estimate,
    j.Act_Equipment_Cost_TTD AS Act_equipment,
    j.Act_Materials_Cost_TTD AS Act_material,
    j.Act_Cost_TTD_UserDef1 AS Act_subs,
    j.Act_Labor_Cost_TTD AS Act_labor,
    j.Act_Cost_TTD_UserDef2 AS Act_burden,
    j.Act_Misc_Other_Cost_TTD AS Act_misc,
    j.Total_Actual_Cost AS Total_actual,
    j.Committed_Equipment_TTD AS Comm_equipment,
    j.Committed_Materials_TTD AS Comm_material,
    j.Committed_TTD_UserDef1 AS Comm_subs,
    j.Committed_Labor_TTD AS Comm_labor,
    j.Committed_Subs_TTD AS Comm_rental,
    j.Committed_Other_TTD AS Comm_other,
    j.Committed_Cost AS Total_committed,
    j.Revsd_Equip_Forecasted AS Forecast_equip,
    j.Revsd_Materials_Forecst AS Forecast_material,
    j.Revsd_Forecast_UserDef1 AS Revised_subs,
    j.Revsd_Labor_Forecasted AS Forecast_labor,
    j.Revsd_Other_Forecst_Cst AS Forecast_other,
    j.Revsd_Forecast_UserDef2 AS Forecast_burden,
    j.Revsd_Forecast_UserDef3 AS Forecast_contingency,
    j.Tot_Revsd_Forecast_Cost AS Total_forecast,
    j.Est_Labor_Units_TTD AS Est_hours,
    j.Act_Labor_Units_TTD AS Act_hours,
    CAST(j.CREATDDT AS date) AS Create_date,
    COALESCE(CAST(h.Close_Date AS date), CAST('1900-01-01 00:00:00.000' AS date)) AS Close_date,
    CASE
        WHEN h.Close_Date IS NOT NULL THEN 'Closed'
        WHEN j.WS_Inactive = 1 THEN 'Inactive'
        ELSE 'Open'
    END AS Status,
    j.Net_Billed_TTD AS Net_billed,
    j.Cash_Received_TTD AS Cash_received,
    CAST(j.Last_Billing_Date AS date) AS Last_billing_date,
    j.Est_Cost_UserDef4 AS Est_warranty,
    j.Act_Cost_TTD_UserDef4 AS Act_warranty,
    j.Revsd_Forecast_UserDef4 AS Forecast_warranty
FROM 
	JC00102 AS j
	LEFT OUTER JOIN
	JC30001 AS h
		ON j.WS_Job_Number = h.WS_Job_Number

UNION

SELECT
    TRIM(h.WS_Job_Number) AS Job_number,
    TRIM(h.WS_Job_Name) AS Job_name,
    TRIM(h.User_Define_1) AS Description,
    CASE
		WHEN h.Divisions LIKE '%_SP_%' THEN 'Special Projects'
		WHEN h.Divisions LIKE '%_HVAC_%' THEN 'Service'
		ELSE NULL
	END AS Division,
	--h.Divisions,
    TRIM(h.Job_Address_Code) AS Location_code,
    TRIM(h.Bill_Customer_Number) AS Customer_code,
    CAST(h.Estimator_ID AS int) AS Salesman_ID,
    h.Expected_Contract AS Expected_contract,
    CAST(h.Calc_Pct_Compl_to_Date AS int) AS Percent_complete,
    h.Est_Equipment_Cost AS Est_equipment,
    h.Est_Material_Cost AS Est_material,
    h.Est_Cost_UserDef1 AS Est_subs,
    h.Est_Labor_Cost AS Est_labor,
    h.Est_Misc_Other_Cost AS Est_misc,
    h.Est_Cost_UserDef2 AS Est_burden,
    h.Est_Cost_UserDef3 AS Contingency,
    h.Total_Estimated_Cost AS Total_estimate,
    h.Act_Equipment_Cost_TTD AS Act_equipment,
    h.Act_Materials_Cost_TTD AS Act_material,
    h.Act_Cost_TTD_UserDef1 AS Act_subs,
    h.Act_Labor_Cost_TTD AS Act_labor,
    h.Act_Cost_TTD_UserDef2 AS Act_burden,
    h.Act_Misc_Other_Cost_TTD AS Act_misc,
    h.Total_Actual_Cost AS Total_actual,
    h.Committed_Equipment_TTD AS Comm_equipment,
    h.Committed_Materials_TTD AS Comm_material,
    h.Committed_TTD_UserDef1 AS Comm_subs,
    h.Committed_Labor_TTD AS Comm_labor,
    h.Committed_Subs_TTD AS Comm_rental,
    h.Committed_Other_TTD AS Comm_other,
    h.Committed_Cost AS Total_committed,
    h.Revsd_Equip_Forecasted AS Forecast_equip,
    h.Revsd_Materials_Forecst AS Forecast_material,
    h.Revsd_Forecast_UserDef1 AS Revised_subs,
    h.Revsd_Labor_Forecasted AS Forecast_labor,
    h.Revsd_Other_Forecst_Cst AS Forecast_other,
    h.Revsd_Forecast_UserDef2 AS Forecast_burden,
    h.Revsd_Forecast_UserDef3 AS Forecast_contingency,
    h.Tot_Revsd_Forecast_Cost AS Total_forecast,
    h.Est_Labor_Units_TTD AS Est_hours,
    h.Act_Labor_Units_TTD AS Act_hours,
    CAST(h.CREATDDT AS date) AS Create_date,
    CAST(h.Close_Date AS date) AS Close_date,
    'Closed' AS Status,
    h.Net_Billed_TTD AS Net_billed,
    h.Cash_Received_TTD AS Cash_received,
    CAST(h.Last_Billing_Date AS date) AS Last_billing_date,
    h.Est_Cost_UserDef4 AS Est_warranty,
    h.Act_Cost_TTD_UserDef4 AS Act_warranty,
    h.Revsd_Forecast_UserDef4 AS Forecast_warranty
FROM
	JC30001 AS h

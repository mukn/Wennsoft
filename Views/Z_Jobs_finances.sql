--ALTER VIEW Z_Jobs_finances AS
WITH JobCosts AS
(
    SELECT
        TRIM(WS_Job_Number) AS Job_number,

        -- Contract
        Expected_Contract AS Expected_contract,
        CAST(Calc_Pct_Compl_to_Date AS INT) AS Percent_complete,

        -- Estimates
        Est_Equipment_Cost   AS Est_equipment,
        Est_Material_Cost    AS Est_material,
        Est_Cost_UserDef1    AS Est_subs,
        Est_Labor_Cost       AS Est_labor,
        Est_Misc_Other_Cost  AS Est_misc,
        Est_Cost_UserDef2    AS Est_burden,
        Est_Cost_UserDef3    AS Contingency,
        Est_Cost_UserDef4    AS Est_warranty,
        Total_Estimated_Cost AS Total_estimate,

        -- Actuals
        Act_Equipment_Cost_TTD  AS Act_equipment,
        Act_Materials_Cost_TTD  AS Act_material,
        Act_Cost_TTD_UserDef1   AS Act_subs,
        Act_Labor_Cost_TTD      AS Act_labor,
        Act_Cost_TTD_UserDef2   AS Act_burden,
        Act_Misc_Other_Cost_TTD AS Act_misc,
        Act_Cost_TTD_UserDef4   AS Act_warranty,
        Total_Actual_Cost       AS Total_actual,

        -- Committed
        Committed_Equipment_TTD AS Comm_equipment,
        Committed_Materials_TTD AS Comm_material,
        Committed_TTD_UserDef1  AS Comm_subs,
        Committed_Labor_TTD     AS Comm_labor,
        Committed_Subs_TTD      AS Comm_rental,
        Committed_Other_TTD     AS Comm_other,
        Committed_Cost          AS Total_committed,

        -- Forecast
        Revsd_Equip_Forecasted  AS Forecast_equip,
        Revsd_Materials_Forecst AS Forecast_material,
        Revsd_Forecast_UserDef1 AS Revised_subs,
        Revsd_Labor_Forecasted  AS Forecast_labor,
        Revsd_Other_Forecst_Cst AS Forecast_other,
        Revsd_Forecast_UserDef2 AS Forecast_burden,
        Revsd_Forecast_UserDef3 AS Forecast_contingency,
        Revsd_Forecast_UserDef4 AS Forecast_warranty,
        Tot_Revsd_Forecast_Cost AS Total_forecast,

        -- Labor
        Est_Labor_Units_TTD AS Est_hours,
        Act_Labor_Units_TTD AS Act_hours
    FROM dbo.JC00102

    UNION ALL

    SELECT
        TRIM(WS_Job_Number) AS Job_number,

        Expected_Contract,
        CAST(Calc_Pct_Compl_to_Date AS INT) AS Percent_complete,

        Est_Equipment_Cost,
        Est_Material_Cost,
        Est_Cost_UserDef1,
        Est_Labor_Cost,
        Est_Misc_Other_Cost,
        Est_Cost_UserDef2,
        Est_Cost_UserDef3,
        Est_Cost_UserDef4,
        Total_Estimated_Cost,

        Act_Equipment_Cost_TTD,
        Act_Materials_Cost_TTD,
        Act_Cost_TTD_UserDef1,
        Act_Labor_Cost_TTD,
        Act_Cost_TTD_UserDef2,
        Act_Misc_Other_Cost_TTD,
        Act_Cost_TTD_UserDef4,
        Total_Actual_Cost,

        Committed_Equipment_TTD,
        Committed_Materials_TTD,
        Committed_TTD_UserDef1,
        Committed_Labor_TTD,
        Committed_Subs_TTD,
        Committed_Other_TTD,
        Committed_Cost,

        Revsd_Equip_Forecasted,
        Revsd_Materials_Forecst,
        Revsd_Forecast_UserDef1,
        Revsd_Labor_Forecasted,
        Revsd_Other_Forecst_Cst,
        Revsd_Forecast_UserDef2,
        Revsd_Forecast_UserDef3,
        Revsd_Forecast_UserDef4,
        Tot_Revsd_Forecast_Cost,

        Est_Labor_Units_TTD,
        Act_Labor_Units_TTD
    FROM dbo.JC30001
)

SELECT
    j.Job_number,

    c.Expected_contract,
    c.Percent_complete,

    -- Estimates
    c.Est_equipment,
    c.Est_material,
    c.Est_subs,
    c.Est_labor,
    c.Est_misc,
    c.Est_burden,
    c.Contingency,
    c.Est_warranty,
    c.Total_estimate,

    -- Actuals
    c.Act_equipment,
    c.Act_material,
    c.Act_subs,
    c.Act_labor,
    c.Act_burden,
    c.Act_misc,
    c.Act_warranty,
    c.Total_actual,

    -- Committed
    c.Comm_equipment,
    c.Comm_material,
    c.Comm_subs,
    c.Comm_labor,
    c.Comm_rental,
    c.Comm_other,
    c.Total_committed,

    -- Forecast
    c.Forecast_equip,
    c.Forecast_material,
    c.Revised_subs,
    c.Forecast_labor,
    c.Forecast_other,
    c.Forecast_burden,
    c.Forecast_contingency,
    c.Forecast_warranty,
    c.Total_forecast,

    -- Labor
    c.Est_hours,
    c.Act_hours

FROM dbo.Z_Jobs_metadata AS j
LEFT JOIN JobCosts AS c
    ON j.Job_number = c.Job_number

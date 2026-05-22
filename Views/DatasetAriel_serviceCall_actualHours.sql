/**    DatasetAriel_serviceCall_actualHours

*/
--ALTER VIEW DatasetAriel_serviceCall_actualHours
WITH DateFilter AS (
    SELECT CAST('2021-01-01' AS DATE) AS MinDate
)
SELECT
    TRIM(cost.Service_Call_ID) AS Work_number,
    TRIM(cost.Divisions)       AS Division,
    TRIM(cost.CUSTNMBR)        AS Customer_code,
    TRIM(cost.ADRSCODE)        AS Location_code,
    cost.TRXHRUNT / 100.0      AS Hours_actual,
    TRIM(cost.EMPLNAME)        AS Employee_name,
    CAST(cost.EMPLOYID AS INT) AS Employee_number
FROM dbo.SV_Costs AS cost
CROSS JOIN DateFilter
WHERE cost.WS_Cost_Code = 6

--ORDER BY Work_number DESC

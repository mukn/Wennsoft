/**		DatasetAriel_serviceCall_estimateHours

		This dataset is a subset of a dataset authored by
		Ariel Morgan. It captures the estimate hours assigned
		to each service call.
*/

--ALTER VIEW DatasetAriel_serviceCall_estimateHours AS

WITH DateFilter AS (
    SELECT CAST('2021-01-01' AS DATE) AS MinDate
),
Contracts AS (
    SELECT CUSTNMBR, ADRSCODE, Contract_Number, WSCONTSQ,
           Contract_Start_Date, Contract_Expiration_Date
    FROM SV00500
    UNION ALL
    SELECT CUSTNMBR, ADRSCODE, Contract_Number, WSCONTSQ,
           Contract_Start_Date, Contract_Expiration_Date
    FROM SV00501
)

-- ==================== PART 1: Service_Call_Task (with deduplication) ====================
SELECT
    --'Service_Call_Task' AS Source_Table,
    TRIM(CUSTNMBR) AS Customer_code,
    TRIM(ADRSCODE) AS Location_code,
    TRIM(Contract_Number) AS Contract_number,
    --WSCONTSQ,
    TRIM(Service_Call_ID) AS Work_number,
    --Task_Code,
    CAST(Estimated_Hours AS float) AS Hours_estimated,
    --Equipment_ID,
    CAST(Schedule_Date AS date) AS Date_schedule
    --1 AS [Required],
    --CorrectContractSequence AS [Correct Contract Sequence]
FROM (
    SELECT
        sh.CUSTNMBR,
        sh.ADRSCODE,
        sh.Contract_Number,
        sh.WSCONTSQ,
        st.Service_Call_ID,
        st.Task_Code,
        CAST(st.Estimate_Hours / 100.0 AS DECIMAL(10,2)) AS Estimated_Hours,
        st.Equipment_ID,
        sh.Date1 AS Schedule_Date,
        c.WSCONTSQ AS CorrectContractSequence,
        ROW_NUMBER() OVER (
            PARTITION BY st.Service_Call_ID, st.Task_Code
            ORDER BY
                CASE WHEN c.Contract_Number = sh.Contract_Number THEN 0 ELSE 1 END,
                c.WSCONTSQ DESC,
                c.Contract_Start_Date DESC
        ) AS rn
    FROM SV00302 st
    INNER JOIN SV00300 sh
        ON st.Service_Call_ID = sh.Service_Call_ID
    LEFT JOIN Contracts c
        ON c.CUSTNMBR = sh.CUSTNMBR
       AND c.ADRSCODE = sh.ADRSCODE
       AND c.Contract_Number = sh.Contract_Number
       AND sh.Date1 >= c.Contract_Start_Date
       AND sh.Date1 <= c.Contract_Expiration_Date
    CROSS JOIN DateFilter
    WHERE COALESCE(st.Estimate_Hours, 0) > 0
      AND COALESCE(st.Task_Code, '') <> 'DEFAULT'
      AND COALESCE(st.Task_Description, '') NOT LIKE '%DEFAULT%'
      AND sh.Date1 >= DateFilter.MinDate
) ranked
WHERE rn = 1


UNION ALL

-- ==================== PART 2: Contract_Task_Schedule ====================
SELECT
    --'Contract_Task_Schedule' AS Source_Table,
    TRIM(cts.CUSTNMBR),
    TRIM(cts.ADRSCODE),
    TRIM(cts.Contract_Number),
    --cts.WSCONTSQ,
    TRIM(cts.Service_Call_ID),
    --cts.Task_Code,
    CAST(cts.Estimate_Hours / 100.0 AS DECIMAL(10,2)) AS [Estimated_Hours],
    --cts.Equipment_ID,
    CAST(cts.Schedule_Date AS date) AS Date_schedule
    --cts.[Required],
    --cts.WSCONTSQ AS [Correct Contract Sequence]
FROM SV00585 cts
INNER JOIN Contracts cm
    ON cts.CUSTNMBR = cm.CUSTNMBR
   AND cts.ADRSCODE = cm.ADRSCODE
   AND cts.Contract_Number = cm.Contract_Number
   AND cts.WSCONTSQ = cm.WSCONTSQ
CROSS JOIN DateFilter
WHERE COALESCE(cts.Estimate_Hours, 0) > 0
  AND cts.[Required] = 1
  AND cm.Contract_Start_Date >= DateFilter.MinDate
  AND cts.Service_Call_ID = ''


--ORDER BY Service_Call_ID DESC

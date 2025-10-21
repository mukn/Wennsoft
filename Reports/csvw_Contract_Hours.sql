/**    csvw_Contract_Hours
      This was authored by Ariel Morgan. Provides an overview of the number of 
      hours available by month per service contract.
*/

-- Declare a variable to filter contracts
DECLARE @contract VARCHAR(10);
SET @contract = '11431LOC23';  -- Wildcard to include all contracts

-- Main query to retrieve scheduled service data with monthly breakdown
SELECT
    -- Customer and location identifiers
    S.CUSTNMBR,                      -- Customer number
    L.CUSTNAME,                     -- Customer name from location table
    S.ADRSCODE,                     -- Address/location code
    L.LOCATNNM,                     -- Location name from location table

    -- Contract identifiers
    TRIM(S.Contract_Number) AS Contract_number,  -- Contract number (trimmed)
    S.WSCONTSQ,                     -- Contract sequence number
    H.Divisions,                   -- Division info from contract header

    -- Equipment and scheduling details
    S.Equipment_ID,                -- Equipment ID
    S.Schedule_Date,              -- Scheduled date of service
    S.Service_Call_ID,            -- Associated service call ID
    CASE
		WHEN S.Estimate_Hours > 0 THEN S.Estimate_Hours / 100.
	END AS Estimate_Hours,             -- Estimated hours for the task
    S.Required,                   -- Whether the task is required (1 = yes)
    S.Original_Schedule_Date,     -- Original scheduled date before changes

    -- Task details
    S.Task_Code,                  -- Task code
    S.Task_Hierarchy,             -- Task hierarchy level
    S.Contract_Task_List_ID,     -- Task list ID for the contract

    -- Monthly breakdown of estimated hours (only if required)
    CASE WHEN MONTH(S.Original_Schedule_Date) = 1 AND S.Required = 1 THEN S.Estimate_Hours / 100.0 ELSE 0 END AS JAN_HOURS,
    CASE WHEN MONTH(S.Original_Schedule_Date) = 2 AND S.Required = 1 THEN S.Estimate_Hours / 100.0 ELSE 0 END AS FEB_HOURS,
    CASE WHEN MONTH(S.Original_Schedule_Date) = 3 AND S.Required = 1 THEN S.Estimate_Hours / 100.0 ELSE 0 END AS MAR_HOURS,
    CASE WHEN MONTH(S.Original_Schedule_Date) = 4 AND S.Required = 1 THEN S.Estimate_Hours / 100.0 ELSE 0 END AS APR_HOURS,
    CASE WHEN MONTH(S.Original_Schedule_Date) = 5 AND S.Required = 1 THEN S.Estimate_Hours / 100.0 ELSE 0 END AS MAY_HOURS,
    CASE WHEN MONTH(S.Original_Schedule_Date) = 6 AND S.Required = 1 THEN S.Estimate_Hours / 100.0 ELSE 0 END AS JUN_HOURS,
    CASE WHEN MONTH(S.Original_Schedule_Date) = 7 AND S.Required = 1 THEN S.Estimate_Hours / 100.0 ELSE 0 END AS JUL_HOURS,
    CASE WHEN MONTH(S.Original_Schedule_Date) = 8 AND S.Required = 1 THEN S.Estimate_Hours / 100.0 ELSE 0 END AS AUG_HOURS,
    CASE WHEN MONTH(S.Original_Schedule_Date) = 9 AND S.Required = 1 THEN S.Estimate_Hours / 100.0 ELSE 0 END AS SEP_HOURS,
    CASE WHEN MONTH(S.Original_Schedule_Date) = 10 AND S.Required = 1 THEN S.Estimate_Hours / 100.0 ELSE 0 END AS OCT_HOURS,
    CASE WHEN MONTH(S.Original_Schedule_Date) = 11 AND S.Required = 1 THEN S.Estimate_Hours / 100.0 ELSE 0 END AS NOV_HOURS,
    CASE WHEN MONTH(S.Original_Schedule_Date) = 12 AND S.Required = 1 THEN S.Estimate_Hours / 100.0 ELSE 0 END AS DEC_HOURS

-- Join location and contract header tables
FROM dbo.SV00585 AS S
INNER JOIN dbo.SV00200 AS L
    ON S.CUSTNMBR = L.CUSTNMBR AND S.ADRSCODE = L.ADRSCODE
INNER JOIN dbo.SV00500 AS H
    ON S.CUSTNMBR = H.CUSTNMBR AND S.ADRSCODE = H.ADRSCODE AND S.Contract_Number = H.Contract_Number

-- Filter conditions
WHERE
    S.Required = 1                          -- Only include required tasks
    AND TRIM(S.Contract_Number) LIKE @contract  -- Filter by contract (wildcard = all)
    AND S.Estimate_Hours > 0               -- Only include tasks with estimated hours

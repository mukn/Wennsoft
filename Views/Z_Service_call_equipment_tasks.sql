/**
    --  Z_Service_call_equipment_tasks
    
    This collects service calls and the highest ranked task
    associated each piece of equipment for that call. This data
    will be passed to users in GoCanvas so that they are aware
    of the service they are to be providing to the equipment.

    */
--ALTER VIEW Z_Service_call_equipment_tasks AS
WITH ranked_tasks AS (
    SELECT
        TRIM(Service_Call_ID) AS Work_number,
        TRIM(Equipment_ID) AS Equipment_code,
        TRIM(Task_code) AS Task_code,
        ROW_NUMBER() OVER (
            PARTITION BY Service_Call_ID, Equipment_ID
            ORDER BY
                CASE
                    WHEN SUBSTRING(Task_code, 1, 3) IN ('AN-', 'SU-', 'WI-') THEN 1
                    WHEN SUBSTRING(Task_code, 1, 3) IN ('IN-', 'RN-', 'RT-') THEN 2
                    WHEN SUBSTRING(Task_code, 1, 3) = 'WAT'                  THEN 3
                    ELSE 4
                END,
                Task_code   -- deterministic tiebreaker within a priority class
        ) AS rn
    FROM SV00302
    WHERE Task_code NOT IN ('HOURS', 'DEFAULT')
)
SELECT
    TRIM(Service_Call_ID) AS Work_number,
    TRIM(Equipment_ID) AS Equipment_code,
    TRIM(Task_code) AS Task_code,
    CASE
        WHEN SUBSTRING(Task_code, 1, 3) IN ('AN-', 'SU-', 'WI-') THEN 'Annual maintenance'
        WHEN SUBSTRING(Task_code, 1, 3) IN ('RT-', 'IN-', 'RN-') THEN 'Routine maintenance'
        WHEN Task_code = 'WATER TRX'                             THEN 'Water treatment'
    END AS Task_type
FROM ranked_tasks
WHERE rn = 1
  --AND Service_Call_ID = '260211-0008'
--ORDER BY Service_Call_ID DESC, Equipment_ID ASC

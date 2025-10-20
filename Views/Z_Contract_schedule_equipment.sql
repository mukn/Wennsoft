--ALTER VIEW Z_Contract_schedule_equipment AS
SELECT DISTINCT Contract_number, Equipment_ID, CAST(Schedule_Date AS date) AS Date_scheduled
FROM SV00585
ORDER BY Contract_Number, Date_scheduled

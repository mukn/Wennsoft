--CREATE VIEW Z_Contract_scheduled_visits_pending AS
SELECT

	v.Contract_Number
	,CAST(v.Schedule_Date AS date) AS Date_scheduled
	,YEAR(v.Schedule_Date) AS Year_scheduled
	,MONTH(v.Schedule_Date) AS Month_scheduled
	,CONCAT(YEAR(v.Schedule_Date),FORMAT(v.Schedule_Date, 'MM'),v.Contract_Number) AS Concat_scheduled
FROM 
	-- 8846 rows
	(SELECT DISTINCT Contract_Number, Schedule_Date FROM SV00585 WHERE Task_code = 'HOURS') AS v
ORDER BY 
	v.Schedule_Date DESC

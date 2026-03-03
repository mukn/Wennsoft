/*
	--Z_Employee_to_technician_map

	This maps employee codes to technician usernames to 
	cross-reference employee codes to entered labor.

*/
--CREATE VIEW Z_Employee_to_technician_map AS
SELECT
	TRIM(Technician_ID) AS Technician_username,
	TRIM(Technician_Team) AS Technician_team,
	TRIM(Technician_Long_Name) AS Technician_name,
	CAST(Employid AS int) AS Employee_code
FROM
	SV00115
WHERE
	Employid <> 0
ORDER BY CAST(Employid AS int)

SELECT
	j.Job_Number
	,j.Location_Code
	,j.Division_Code
	,CASE
		WHEN Division_Code LIKE '%_HVAC_%' THEN 'Service'
		WHEN Division_Code LIKE '%_SP_%' THEN 'Special Projects'
		ELSE NULL
	END AS Division_name
	,CASE
		WHEN Division_Code LIKE '%_HVAC_%' THEN 'dispatch@nacgroup.com'
		WHEN Division_Code LIKE '%_SP_%' THEN 'sp_operations@nacgroup.com'
		ELSE NULL
	END AS Division_email
FROM
	Z_Active_Jobs AS j

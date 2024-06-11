SELECT
	j.Job_Number
	,j.Location_Code
	,j.Division_Code
	,CASE
		WHEN Division_Code LIKE '%_HVAC_%' THEN 'dispatch@nacgroup.com'
		WHEN Division_Code LIKE '%_SP_%' THEN 'special-projects@nacgroup.com'
		ELSE NULL
	END AS Division_email
FROM
	Z_Active_Jobs AS j

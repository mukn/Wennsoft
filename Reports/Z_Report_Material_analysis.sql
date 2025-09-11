SELECT
	TRIM(u.WS_Job_Number) AS Job_number,
	u.User_Define_4 AS Material_analysis

	,u.*
FROM
	JC00107 AS u

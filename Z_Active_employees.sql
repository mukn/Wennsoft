SELECT
	CAST(em.EMPLOYID AS int) AS Employee_Number
	,TRIM(em.FRSTNAME) AS Employee_FirstName
	,TRIM(em.LASTNAME) AS Employee_LastName
	,TRIM(em.DEPRTMNT) AS Employee_UnionCode
	,TRIM(em.JOBTITLE) AS Employee_PayCode
	,CASE
		WHEN CAST(em.LOCATNID AS int) = '0' THEN NULL
		ELSE CAST(em.LOCATNID AS int)
	END  AS Employee_Location
	--,em.*
FROM
	UPR00100 AS em
WHERE
	em.Inactive = 0			-- Filter out terminated employees
ORDER BY
	CAST(EMPLOYID as int)

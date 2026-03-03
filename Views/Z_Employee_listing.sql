/*
	-- Z_Employee_listing

	This is a listing of employees, job codes, and department codes.

	References:
	 - UPR00100 - Payroll Master
	 - UPR40300 - Payroll Department Setup

*/
--CREATE VIEW Z_Employee_listing AS 
SELECT 
	
	CAST(emp.EMPLOYID AS int) AS Employee_code,
	TRIM(emp.LASTNAME) AS Employee_LastName,
	TRIM(emp.FRSTNAME) AS Employee_FirstName,
	TRIM(emp.JOBTITLE) AS Employee_JobCode,
	TRIM(emp.DEPRTMNT) AS Department_code,
	TRIM(dep.DSCRIPTN) AS Department_name
	--,emp.*
FROM
	UPR00100 AS emp
	LEFT OUTER JOIN
	UPR40300 AS dep
		ON emp.DEPRTMNT = dep.DEPRTMNT

--ORDER BY CAST(emp.EMPLOYID AS int)

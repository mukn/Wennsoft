SELECT
	TRIM(c.CUSTNMBR) AS Customer_code
	,TRIM(c.adrscode) AS Location_code
	,TRIM(c.Contract_Number) AS Contract_number
	,TRIM(c.Equipment_ID) AS Equipment_name
	,LEFT(c.Task_code, 2) AS Task_code
	--,TRIM(Task_Code) AS Task_ID
	,c.Contract_Task_List_ID 

FROM
	SV00585 AS c
	LEFT OUTER JOIN
	SV00501 AS h
		ON c.Contract_Number = h.Contract_Number

WHere 
	Required = '1'
	And c.Contract_Number in (SELECT Contract_Number FROM SV00500)
	AND h.Contract_Number IS NULL
	
GROUP BY c.CUSTNMBR, c.adrscode, c.Contract_Number, c.Equipment_ID, LEFT(Task_code, 2), c.Contract_Task_List_ID
ORDER BY Customer_code, Location_code, c.Contract_number, c.Equipment_ID

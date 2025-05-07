SELECT
	TRIM(CUSTNMBR) AS Customer_code
	,TRIM(adrscode) AS Location_code
	,TRIM(Contract_Number) AS Contract_number
	,TRIM(Equipment_ID) AS Equipment_name
	,LEFT(Task_code, 2) AS Task_code
	--,TRIM(Task_Code) AS Task_ID
	,Contract_Task_List_ID 

FROM
	SV00585

WHere 
	Required = '1'
	And Contract_Number in (SELECT Contract_Number FROM SV00500)
	
GROUP BY CUSTNMBR, adrscode, Contract_Number, Equipment_ID, LEFT(Task_code, 2), Contract_Task_List_ID
ORDER BY Customer_code, Location_code, Contract_number, Equipment_ID

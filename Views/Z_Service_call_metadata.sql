/**		-- Z_Service_call_metadata

*/
--CREATE VIEW Z_Service_call_metadata AS
SELECT
	TRIM(s.Service_Call_ID) AS Work_number
	,TRIM(s.ADRSCODE) AS Location_code
	,TRIM(s.CUSTNMBR) AS Customer_code
	,TRIM(s.Contract_Number) AS Contract_code
	,TRIM(s.Service_Description) AS Work_description
	,TRIM(s.Technician_ID) AS Technician_primary
	,TRIM(s.Technician) AS Technician_assigned
	,TRIM(s.Resolution_ID) AS Status_code
	,TRIM(s.Type_Call_Short) AS Type_code
	,TRIM(s.Status_of_Call) AS Status
	,CAST(s.Date_of_Service_Call AS date) AS Date_call
	,CAST(s.Completion_Date AS date) AS Date_complete
	--,*
FROM
	SV00300 AS s

--ORDER BY Work_number DESC

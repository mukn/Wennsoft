-- Warm leads report
/** We define warm leads as locations that have a project sale in the last 90 days
but do not have a service contract.
**/


-- Jobs
SELECT
	TRIM(j.WS_Job_Number) AS Job_number,
	TRIM(j.WS_Job_Name) AS Job_name,
	TRIM(j.Divisions) AS Division,
	TRIM(j.CUSTNMBR) AS Customer_code,
	TRIM(j.Job_Address_Code) AS Location_code,
	TRIM(j.User_Define_1) AS Job_description,
	--j.Calc_Pct_Compl_to_Date,
	CREATDDT AS Date_created,
	CAST(Estimator_ID AS int) AS SalesRep,
	CASE
		WHEN s.Location_code IS NOT NULL THEN 'No contract'
	END AS Contract_status
	--,j.*
FROM
	JC00102 AS j               -- Job master
	LEFT OUTER JOIN
	Z_Active_locations_without_service_contract AS s              -- Locations without service contracts
		ON TRIM(j.CUSTNMBR) = s.Customer_code 
		AND TRIM(j.Job_Address_Code) = s.Location_code

WHERE 
	CREATDDT > (GETDATE() - 90)
	AND s.Location_code IS NOT NULL

ORDER BY Date_created DESC

--CREATE VIEW Z_Jobs_metadata AS
SELECT
	TRIM(j.WS_Job_Number) AS Job_number
	,TRIM(j.Divisions) AS Division_code
	,CASE
		WHEN j.Divisions LIKE '%_HVAC_%' THEN 'Service'
		WHEN j.Divisions LIKE '%_SP_%' THEN 'Special Projects'
		ELSE NULL
	END AS Division_name
	,CASE
		WHEN j.Divisions LIKE '%_HVAC_%' THEN 'dispatch@nacgroup.com'
		WHEN j.Divisions LIKE '%_SP_%' THEN 'sp_operations@nacgroup.com'
		ELSE NULL
	END AS Division_email
	,TRIM(j.CUSTNMBR) AS Customer_code
	,TRIM(j.Job_Address_Code) AS Location_code
	,TRIM(j.WS_Job_Name) AS Job_description
	,CASE
        WHEN h.Close_Date IS NOT NULL THEN 'Closed'
        WHEN j.WS_Inactive = 1 THEN 'Inactive'
        ELSE 'Open'
    END AS Job_status
	,'' AS Job_scope			-- This will likely come from UDFs

FROM
	JC00102 AS j
	LEFT OUTER JOIN
	JC30001 AS h
		ON j.WS_Job_Number = h.WS_Job_Number

UNION

SELECT
	TRIM(h.WS_Job_Number) AS Job_number
	,TRIM(h.Divisions) AS Division_code
	,CASE
		WHEN h.Divisions LIKE '%_HVAC_%' THEN 'Service'
		WHEN h.Divisions LIKE '%_SP_%' THEN 'Special Projects'
		ELSE NULL
	END AS Division_name
	,CASE
		WHEN h.Divisions LIKE '%_HVAC_%' THEN 'dispatch@nacgroup.com'
		WHEN h.Divisions LIKE '%_SP_%' THEN 'sp_operations@nacgroup.com'
		ELSE NULL
	END AS Division_email
	,TRIM(h.CUSTNMBR) AS Customer_code
	,TRIM(h.Job_Address_Code) AS Location_code
	,TRIM(h.WS_Job_Name) AS Job_description
	,'Closed' AS Job_status
	,'' AS Job_scope			-- This will likely come from UDFs

FROM
	JC30001 AS h

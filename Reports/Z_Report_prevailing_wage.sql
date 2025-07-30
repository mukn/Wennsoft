/**		Prevailing wage report
		Maryland 2025

		Jeremy Lunsford
		30 July 2025

		Project start date
		Completion flag
		Project complete date
		Project name
		Project location
		Project Zip
		Project county
		Project city
		Project type
		Project estimated hours
		Project worker quantity
		Project value
		CBA used
		Description
		General contractor
		Contact name
		Contact phone
		Contact email

		**/



-- Working

SELECT
	TRIM(j.WS_Job_Number) AS Job_number,
	TRIM(j.Divisions) AS Division,
	--TRIM(j.Job_Address_Code) AS Location_code,
	--TRIM(j.CUSTNMBR) AS Customer_code,
	TRIM(j.WS_Job_Name) AS Job_name,
	l.Location_address1,
	l.Location_city,
	l.Location_state,
	l.Locaiton_zip,
	j.Estimator_ID AS SalesRep_code,
	j.WS_Manager_ID AS PM_code,
	CASE
		WHEN j.Schedule_Start_Date > 1899-12-31 THEN j.Schedule_Start_Date
		ELSE NULL
	END AS Estimated_StartDate,
	CASE
		WHEN j.Sched_Completion_Date > 1899-12-31 THEN j.Sched_Completion_Date
		ELSE NULL
	END AS Estimated_EndDate,
	CASE
		WHEN j.ACTCOMPDATE  > 1899-12-31 THEN j.ACTCOMPDATE
		ELSE NULL
	END AS Actual_EndDate,
	j.Est_Labor_Cost AS Estimated_LaborCost,
	j.Est_Labor_Units_TTD AS Estimated_LaborHours
	--,*
FROM
	JC00102 as j					-- 438 before location join
	LEFT OUTER JOIN
	(
		SELECT
			TRIM(CUSTNMBR) AS Customer_code,
			TRIM(ADRSCODE) AS Location_code,
			TRIM(CUSTNAME) AS Customer_name,
			TRIM(LOCATNNM) AS Location_name,
			TRIM(ADDRESS1) AS Location_address1,
			TRIM(CITY) AS Location_city,
			TRIM(STATE) AS Location_state,
			TRIM(ZIP) AS Locaiton_zip
			--,*
		FROM SV00200					-- 1842 rows
		WHERE ADRSCODE <> 'MAIN'
	) AS l
		ON 
			TRIM(j.CUSTNMBR) = l.Customer_code AND
			TRIM(j.Job_Address_Code) = l.Location_code










-- Job transaction open, limited to labor
	-- To be grouped and reduced to earliest date by MIN() to create start date
select * from JC20001 WHERE Cost_Element = 1


/**		References

select * from GL00100				-- Account master
SELECT * FROM JC00102
select * from JC00701				-- Job detail master
select * FROM SV00200				-- 

*/

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
--ALTER VIEW [Z_view_ReportPrevailingWage] AS
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
	/*CASE
		WHEN JC.Earliest_Date IS NULL THEN
			CASE
				WHEN j.Schedule_Start_Date > 1899-12-31 THEN j.Schedule_Start_Date
				ELSE NULL
			END
		ELSE JC.Earliest_Date
	END AS Estimated_StartDate,*/
	--CASE
	--	WHEN j.Schedule_Start_Date > 1899-12-31 THEN j.Schedule_Start_Date
	--	ELSE NULL
	--END AS Estimated_StartDate,
	JC2.[Week Start],
	JC2.[Week End],
	CASE
		WHEN j.Sched_Completion_Date > 1899-12-31 THEN j.Sched_Completion_Date
		ELSE NULL
	END AS Estimated_EndDate,
	CASE
		WHEN j.ACTCOMPDATE  > 1899-12-31 THEN j.ACTCOMPDATE
		ELSE NULL
	END AS Actual_EndDate,
	CASE
		WHEN (
			-- Estimated_StartDate
			CASE
				WHEN JC.Earliest_Date IS NULL THEN
					CASE
						WHEN j.Schedule_Start_Date > 1899-12-31 THEN j.Schedule_Start_Date
						ELSE NULL
					END
				ELSE JC.Earliest_Date
			END
		) IS NULL THEN NULL
		ELSE JC2.[Labor Sum]
	END AS [Week_Labor_Sum],
	JC3.[Max_Labor_Sum],
	CASE
		WHEN (
			-- Estimated_StartDate
			CASE
				WHEN JC.Earliest_Date IS NULL THEN
					CASE
						WHEN j.Schedule_Start_Date > 1899-12-31 THEN j.Schedule_Start_Date
						ELSE NULL
					END
				ELSE JC.Earliest_Date
			END
		) IS NULL THEN NULL
		ELSE JC2.[Week]
	END AS [Week_Num],
	j.Est_Labor_Cost AS Estimated_LaborCost,
	j.Est_Labor_Units_TTD AS Estimated_LaborHours,
  j.Orig_Contract_Amount AS Contract_price,
  j.User_Define_1 AS Job_Description
	--,*

FROM
	JC00102 as j					-- 438 before location join
	LEFT OUTER JOIN (
		SELECT WS_Job_Number, MIN(DOCDATE) AS Earliest_Date
		FROM [NAC].[dbo].[JC20001]
		WHERE Cost_Element = 1
		GROUP BY WS_Job_Number
	) AS JC ON JC.WS_Job_Number = j.WS_Job_Number
	LEFT OUTER JOIN (
		SELECT 
			WS_Job_Number,
			s.[Year],
			s.[Week] AS [Week],
			s.[Week Start],
			s.[Week End],
			CAST(SUM(s.Labor) AS DECIMAL(10,2))/100 AS [Labor Sum]
		FROM (
			SELECT 
				WS_Job_Number, 
				DATEPART(WEEK, DOCDATE) AS [Week],
				DATEPART(YEAR, DOCDATE) AS [Year],
				CONVERT(varchar(50), (DATEADD(DAY, @@DATEFIRST - DATEPART(WEEKDAY, DOCDATE) - 6, DOCDATE)), 101) AS [Week Start],
				CONVERT(varchar(50), (DATEADD(DAY, @@DATEFIRST - DATEPART(WEEKDAY, DOCDATE), DOCDATE)), 101) AS [Week End],
				DOCDATE,
				(Monday+Tuesday+Wednesday+Thursday+Friday+Saturday+Sunday) AS [Labor]
			FROM [NAC].[dbo].[JC20001]
			WHERE Cost_Element = 1
		) AS s
		GROUP BY s.[Year], s.[Week], s.[Week Start], s.[Week End], WS_Job_Number
	) AS JC2 ON JC2.[Week] = DATEPART(
		WEEK, (
			-- Estimated_StartDate
			CASE
				WHEN JC.Earliest_Date IS NULL THEN
					CASE
						WHEN j.Schedule_Start_Date > 1899-12-31 THEN j.Schedule_Start_Date
						ELSE NULL
					END
				ELSE JC.Earliest_Date
			END
		)
	) AND JC2.[Year] = DATEPART(
		YEAR, (
			-- Estimated_StartDate
			CASE
				WHEN JC.Earliest_Date IS NULL THEN
					CASE
						WHEN j.Schedule_Start_Date > 1899-12-31 THEN j.Schedule_Start_Date
						ELSE NULL
					END
				ELSE JC.Earliest_Date
			END
		)
	) AND JC2.WS_Job_Number = j.WS_Job_Number
	LEFT OUTER JOIN (
		SELECT 
			s2.WS_Job_Number,
			MAX(s2.[Labor Sum]) AS [Max_Labor_Sum]
		FROM (
			SELECT 
				s.WS_Job_Number,
				s.[Year],
				s.[Week],
				s.[Week Start],
				s.[Week End],
				CAST(SUM(s.Labor) AS DECIMAL(10,2))/100 AS [Labor Sum]
			FROM (
				SELECT 
					WS_Job_Number, 
					DATEPART(WEEK, DOCDATE) AS [Week],
					DATEPART(YEAR, DOCDATE) AS [Year],
					CONVERT(varchar(50), (DATEADD(DAY, @@DATEFIRST - DATEPART(WEEKDAY, DOCDATE) - 6, DOCDATE)), 101) AS [Week Start],
					CONVERT(varchar(50), (DATEADD(DAY, @@DATEFIRST - DATEPART(WEEKDAY, DOCDATE), DOCDATE)), 101) AS [Week End],
					DOCDATE,
					(Monday+Tuesday+Wednesday+Thursday+Friday+Saturday+Sunday) AS [Labor]
				FROM [NAC].[dbo].[JC20001]
				WHERE Cost_Element = 1
				--ORDER BY DATEPART(WEEK, DOCDATE)
			) AS s
			GROUP BY s.[Year], s.[Week], s.[Week Start], s.[Week End], WS_Job_Number
			--ORDER BY SUM(s.Labor) DESC, s.[Week], WS_Job_Number
		) AS s2
		GROUP BY s2.WS_Job_Number
		--ORDER BY s2.WS_Job_Number
	) AS JC3 ON JC3.WS_Job_Number = j.WS_Job_Number
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
 
--WHERE j.WS_Job_Number LIKE '%24030539SM%'
 
 
 
 
-- Job transaction open, limited to labor
	-- To be grouped and reduced to earliest date by MIN() to create start date
-- select * from JC20001 WHERE Cost_Element = 1
 
 
/**		References
 
select * from GL00100				-- Account master
SELECT * FROM JC00102
select * from JC00701				-- Job detail master
select * FROM SV00200				--
 
*/

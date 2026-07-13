CREATE VIEW Z_Jobs_dates AS
SELECT
	j.Job_number
	,CASE
		WHEN Date_SchedStart = '1900-01-01' THEN NULL
		ELSE Date_SchedStart
	END AS Date_SchedStart
	,CASE
		WHEN Date_SchedComplete = '1900-01-01' THEN NULL
		ELSE Date_SchedComplete
	END AS Date_SchedComplete
	,CASE
		WHEN Date_ActualComplete = '1900-01-01' THEN NULL
		ELSE Date_ActualComplete
	END AS Date_ActualComplete

FROM
	Z_Jobs_metadata AS j
	LEFT OUTER JOIN
	(SELECT
		TRIM(WS_Job_Number) AS Job_number
		,CAST(Schedule_Start_Date AS date) AS Date_SchedStart
		,CAST(Sched_Completion_Date AS date) AS Date_SchedComplete
		,CAST(ACTCOMPDATE AS date) AS Date_ActualComplete
	FROM JC00102
	UNION
	SELECT
		TRIM(WS_Job_Number) AS Job_number
		,CAST(Schedule_Start_Date AS date) AS Date_SchedStart
		,CAST(Sched_Completion_Date AS date) AS Date_SchedComplete
		,CAST(ACTCOMPDATE AS date) AS Date_ActualComplete
	FROM JC30001) AS d
		ON j.Job_number = d.Job_number


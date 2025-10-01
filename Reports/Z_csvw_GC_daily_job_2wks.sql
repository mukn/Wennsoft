/** Daily job time retrieved from GoCanvas. Rolling two week window. */
--ALTER VIEW Z_csvw_GC_daily_job_2wks AS
SELECT --TOP (1000) 
	h.ID
	,h.SubmissionFormName AS Form
	,h.SubmissionID
	,t.SubmissionID_List_2 AS SubmissionID_validate
	,t.Employee_List_2 AS Employee_name
	,CAST(h.Date AS DATE) AS Employee_WorkDate
	,t.RegularTime_List_2 AS Employee_RegTime
	,t.Overtime_List_2 AS Employee_OverTime
	,t.DoubleTime_List_2 AS Employee_DoubleTime
	,t.ShiftTime_List_2 AS Employee_ShiftTime
	
	,h.Username
	,h.UserLastName
	,h.UserFirstName
	,h.SubmissionCreationDateTime
	,h.DeviceDateTime
	,h.SubmissionFormVersion
	,h.SubmissionNo
	,h.Date
	,h.JobName
	,'QUOTED' AS JobType
	,h.JobStatus
	,h.Appointment
	,h.AppointmentID
	,h.DispatchID
	,h.JobNumber
	,h.WarrantyJobNumber
FROM
	nac.DailyJobSiteReportSubmission AS h
	JOIN
	nac.DailyJobSiteReportSubmissionList2 AS t
		ON h.SubmissionID = t.SubmissionID_List_2

WHERE
	CAST(h.Date AS DATE) > GETDATE() - 14

ORDER BY
	CAST(h.Date AS DATE) DESC

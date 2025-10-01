/** Scheduled PM time retrieved from GoCanvas. Rolling two week window. */
--ALTER VIEW Z_csvw_GC_scheduled_pm_2wks AS
SELECT --TOP (1000)
	h.ID
	,h.SubmissionFormName AS Form
	,h.SubmissionID AS SubmissionID
	,t.SubmissionID_List_22 AS SubmissionID_validate
	,t.Employee_List_22 AS Employee_name
	,CAST(h.Date AS DATE) AS Employee_WorkDate
	,t.HiddenTimeDec_List_22 AS Employee_RegTime
	,t.HiddenOTDec_List_22 AS Employee_OverTime
	,0 AS Employee_DoubleTime
	,0 AS Employee_ShiftTime
	,h.Username
	,h.UserLastName
	,h.UserFirstName
	,h.SubmissionCreationDateTime
	,h.DeviceDateTime
	,h.SubmissionFormVersion
	,h.SubmissionNo
	,h.Date
	,h.JobNameD
	,'MAINTENANCE' AS JobType
	,h.JobStatus
	,h.Appointment
	,h.AppointmentID
	,h.DispatchID
	,h.WO_Number

FROM 
	nac.ScheduledPMSubmission AS h
	JOIN
	nac.ScheduledPMSubmissionList22 AS t
		ON h.SubmissionID = t.SubmissionID_List_22

WHERE
	CAST(h.Date AS DATE) > GETDATE() - 14

ORDER BY
	CAST(h.Date AS DATE) DESC

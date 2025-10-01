/** Work order ticket time retrieved from GoCanvas. Rolling two week window. */
--ALTER VIEW Z_csvw_GC_work_order_time_2wks AS
SELECT 
	h.ID
	,h.SubmissionFormName AS Form
	,h.SubmissionID AS SubmissionID
	,t.SubmissionID_List_15 AS SubmissionID_validate
	,t.Employee_List_15 AS Employee_name
	,CAST(t.DateOfService_List_15 AS DATE) AS Employee_WorkDate
	,t.RegularTime_List_15 AS Employee_RegTime
	,t.Overtime_List_15 AS Employee_OverTime
	,t.DoubleTime_List_15 AS Employee_DoubleTime
	,t.ShiftTime_List_15 AS Employee_ShiftTime
	,h.Username
	,h.UserLastName
	,h.UserFirstName
	,h.SubmissionCreationDateTime
	,h.DeviceDateTime
	,h.SubmissionFormVersion
	,h.SubmissionNo
	,h.Date
	,h.JobName
	,h.JobType
	,h.JobStatus
	,h.Appointment
	,h.AppointmentID
	,h.DispatchID
	,h.WO_Number
FROM 
	nac.WorkOrderTicketSubmission AS h
	JOIN
	nac.WorkOrderTicketSubmissionList15 AS t
		ON h.SubmissionID = t.SubmissionID_List_15

WHERE
	CAST(t.DateOfService_List_15 AS DATE) > GETDATE() - 14

--ORDER BY 
--	CAST(t.DateOfService_List_15 AS DATE) DESC

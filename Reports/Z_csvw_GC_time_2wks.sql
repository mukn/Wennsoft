/**
	A union of the submitted time from GoCanvas on a rolling two week window.
	*/
--ALTER VIEW Z_csvw_GC_time_2wks AS
SELECT ID,Form,SubmissionID,SubmissionID_validate,Employee_name,Employee_workDate,Employee_regtime,Employee_overtime,Employee_doubletime,Employee_shifttime,username,userlastname,userfirstname,submissioncreationdatetime,devicedatetime,submissionformversion,submissionno,date,jobname,jobstatus,appointment,appointmentid,dispatchid,CASE WHEN jobnumber NOT like 'WRRNTY%' then jobnumber else warrantyjobnumber end as worknumber

FROM [NAC\jlunsford].Z_csvw_GC_daily_job_2wks
	

UNION

SELECT ID,Form,SubmissionID,SubmissionID_validate,Employee_name,Employee_workDate,Employee_regtime,Employee_overtime,Employee_doubletime,Employee_shifttime,username,userlastname,userfirstname,submissioncreationdatetime,devicedatetime,submissionformversion,submissionno,date,jobname,jobstatus,appointment,appointmentid,dispatchid,WO_number

FROM [NAC\jlunsford].Z_csvw_GC_scheduled_pm_2wks

UNION

SELECT ID,Form,SubmissionID,SubmissionID_validate,Employee_name,Employee_workDate,Employee_regtime,Employee_overtime,Employee_doubletime,Employee_shifttime,username,userlastname,userfirstname,submissioncreationdatetime,devicedatetime,submissionformversion,submissionno,date,jobname,jobstatus,appointment,appointmentid,dispatchid,WO_number

FROM [NAC\jlunsford].Z_csvw_GC_work_order_time_2wks

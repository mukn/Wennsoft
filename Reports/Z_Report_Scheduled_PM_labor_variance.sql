/**		-- Scheduled PM labor variance to budget
	This is a report comparing hours budgeted per service call to 
	the labor reporting we get back from GoCanvas.

	This still needs to get status and equipment lists per call.
	Additional analysis should attempt to factor in expected time
	for each piece of equipment and segmented out against the 
	technician completing the work and the location of the work. Each
	of those are likely to reveal trends that are worth pursuing.

*/
--CREATE VIEW Z_Report_Scheduled_PM_labor_variance AS
SELECT
	b.Work_number,
	s.Employee_name,
	b.Actual_hours,
	b.Appointment_hours AS Budget_hours,
	CASE
		WHEN b.Appointment_hours > 0 THEN (b.Actual_hours / b.Appointment_hours)
		ELSE 0
	END AS Variance_percent,
	(b.Appointment_hours - b.Actual_hours) AS Variance_hours,
	s.Appointment,
	s.Employee_RegTime,
	s.Employee_OverTime,
	s.Employee_DoubleTime,
	s.Employee_ShiftTime,
	(s.Employee_RegTime + s.Employee_OverTime + s.Employee_DoubleTime + s.Employee_ShiftTime) AS Employee_totalTime
	--,b.*

FROM
	Z_Service_call_actual_and_budget_hours AS b
	JOIN
	NACGoCanvas.nac.Z_Labor_hours_scheduled_pm_submission_52wks AS s
		ON b.Work_number = s.Work_number

--WHERE s.Work_number = '260701-0235'
--ORDER BY b.Work_number DESC, s.Appointment, s.Employee_name ASC

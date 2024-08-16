SELECT
	TRIM(s.Service_Call_ID) AS WO_Number
	,TRIM(s.Resolution_ID) AS Resolution_ID
	,TRIM(s.Resolution_Description) AS Resolution_Description
	,TRIM(s.Status_of_Call) AS Complete_Status
	,TRIM(s.Service_Description) AS Description
	,TRIM(l.LOCATNNM) AS Location_Name
	,CASE
		WHEN TRIM(s.Type_Call_Short) = 'MCC' THEN 'PM'
		ELSE NULL
	END AS PM_Flag
	--,TRIM(s.Technician) AS Technician_ID
	,t.Technician AS Technician_ID
	,TRIM(s.Type_Call_Short) AS Call_Type_ID
	,TRIM(s.Type_of_call) AS Call_Type_Description
	,s.Date1 AS Date_Entered
	,s.Date_of_Service_Call AS Appointment_Date
	,CASE
		WHEN s.Completion_Date > 1901-01-01 THEN s.Completion_Date
		ELSE NULL
	END AS Complete_Date
	
	--,'' AS Date_Requested
	--,'' AS Date_Assigned
	--,'' AS Contact_Notes
	--,*

FROM 
	SV00300 AS s
	LEFT OUTER JOIN
	SV00115 AS t
		ON s.Technician = t.Technician_ID
	LEFT OUTER JOIN
	SV00200 AS l
		ON s.CUSTNMBR = l.CUSTNMBR
			AND s.ADRSCODE = l.ADRSCODE

WHERE
	s.Status_of_Call <> 'CLOSED'

ORDER BY TRIM(s.Service_Call_ID) DESC

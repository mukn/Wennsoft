/**
	Z_Service_contract_call_equipment_worked

	This collects all equipment that was worked for each work order.
	NULL values indicates that the user did not use the task list as
	recorded in GoCanvas.

*/
--CREATE VIEW Z_Service_contract_call_equipment_worked AS
SELECT		--TOP 100
	m.SubmissionID AS SubID
	,m.Username
	,CAST(m.SubmissionCreationDateTime AS date) AS Submission_date
	,m.WO_Number
	,m.ProjectDescriptionD
	,Equipment.Equipment_ID
	--,Equipment.Equipment_recommendations
	--,*
FROM 
	NACGoCanvas.nac.ScheduledPMSubmission AS m
	LEFT OUTER JOIN
	(SELECT SubmissionID_List_1 AS SubID, BoilerID_List_1 AS Equipment_ID, Recommendations_List_1 AS Equipment_recommendations
		FROM NACGoCanvas.nac.scheduledpmsubmissionlist1
	UNION
	SELECT --TOP 100 *
		SubmissionID_List_2 AS SubID, ChillerID_List_2 AS Equipment_ID, Recommendations_List_2 AS Equipment_recommendations
		FROM NACGoCanvas.nac.scheduledpmsubmissionlist2
	UNION
	SELECT --TOP 100 *
		SubmissionID_List_3 AS SubID, CellID_List_3 AS Equipment_ID, Recommendations_List_3 AS Equipment_recommendations
		FROM NACGoCanvas.nac.scheduledpmsubmissionlist3
	UNION
	SELECT --TOP 100 *
		SubmissionID_List_4 AS SubID, PumpID_List_4 AS Equipment_ID, Recommendations_List_4 AS Equipment_recommendations
		FROM NACGoCanvas.nac.scheduledpmsubmissionlist4
	UNION
	SELECT --TOP 100 *
		SubmissionID_List_5 AS SubID, AIRHandlingUnitID_List_5 AS Equipment_ID, Recommendations_List_5 AS Equipment_recommendations
		FROM NACGoCanvas.nac.scheduledpmsubmissionlist5
	UNION
	SELECT --TOP 100 *
		SubmissionID_List_6 AS SubID, FanCoilUnit_List_6 AS Equipment_ID, Recommendations_List_6 AS Equipment_recommendations
		FROM NACGoCanvas.nac.scheduledpmsubmissionlist6
	UNION
	SELECT --TOP 100 *
		SubmissionID_List_7 AS SubID, UnitID_List_7 AS Equipment_ID, Recommendations_List_7 AS Equipment_recommendations
		FROM NACGoCanvas.nac.scheduledpmsubmissionlist7
	UNION
	SELECT --TOP 100 *
		SubmissionID_List_8 AS SubID, SplitSystemID_List_8 AS Equipment_ID, Recommendations_List_8 AS Equipment_recommendations
		FROM NACGoCanvas.nac.scheduledpmsubmissionlist8
	UNION
	SELECT --TOP 100 *
		SubmissionID_List_9 AS SubID, DryCoolerID_List_9 AS Equipment_ID, Recommendations_List_9 AS Equipment_recommendations
		FROM NACGoCanvas.nac.scheduledpmsubmissionlist9
	UNION
	SELECT --TOP 100 *
		SubmissionID_List_10 AS SubID, ExhaustFanID_List_10 AS Equipment_ID, '' AS Equipment_recommendations
		FROM NACGoCanvas.nac.scheduledpmsubmissionlist10
	UNION
	SELECT --TOP 100 *
		SubmissionID_List_11 AS SubID, VDFID_List_11 AS Equipment_ID, Recommendations_List_11 AS Equipment_recommendations
		FROM NACGoCanvas.nac.scheduledpmsubmissionlist11
	UNION
	SELECT --TOP 100 *
		SubmissionID_List_16 AS SubID, AirCompressorID_List_16 AS Equipment_ID, Recommendations_List_16 AS Equipment_recommendations
		FROM NACGoCanvas.nac.scheduledpmsubmissionlist16
	UNION
	SELECT --TOP 100 *
		SubmissionID_List_17 AS SubID, AirDryerID_List_17 AS Equipment_ID, Recommendations_List_17 AS Equipment_recommendations
		FROM NACGoCanvas.nac.scheduledpmsubmissionlist17
	UNION
	SELECT --TOP 100 *
		SubmissionID_List_18 AS SubID, DuctUnitHeaterID_List_18 AS Equipment_ID, '' AS Equipment_recommendations
		FROM NACGoCanvas.nac.scheduledpmsubmissionlist18
	UNION
	SELECT --TOP 100 *
		SubmissionID_List_19 AS SubID, HeatExchangerID_List_19 AS Equipment_ID, Recommendations_List_19 AS Equipment_recommendations
		FROM NACGoCanvas.nac.scheduledpmsubmissionlist19
	UNION
	SELECT --TOP 100 *
		SubmissionID_List_20 AS SubID, HumidifierType_List_20 AS Equipment_ID, Recommendations_List_20 AS Equipment_recommendations
		FROM NACGoCanvas.nac.scheduledpmsubmissionlist20) AS Equipment
		ON m.SubmissionID = Equipment.SubID

WHERE
	--Equipment.Equipment_ID IS NULL OR			-- 11608 rows
	--Equipment.Equipment_ID IS NOT NULL AND			-- 29666 rows
	m.SubmissionCreationDateTime > GETDATE() - 30

ORDER BY Username ASC

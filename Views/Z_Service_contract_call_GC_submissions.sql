/**
	Z_Service_contract_call_GC_submissions.sql

	This collects the service calls and the corresponding submission
	ID for that service call. Used to cross-reference in other 
	datasets.

*/
-- Calls and submissions
--CREATE VIEW Z_Service_contract_call_GC_submissions AS
SELECT DISTINCT
	e.WO_number,
	w.SubID

FROM
	Z_Service_call_equipment AS e
	RIGHT JOIN
	Z_Service_contract_call_equipment_worked AS w
		ON e.WO_number = w.WO_Number
			

--ORDER BY e.WO_number DESC

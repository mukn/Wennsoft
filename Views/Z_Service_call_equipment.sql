/**
	Z_Service_call_equipment

	This collects equipment that is to be worked on each service call. This
	will be used to verify that all equipment has been worked before closing
	out the service call.

*/
--CREATE VIEW Z_Service_call_equipment AS
SELECT DISTINCT Service_Call_ID, Equipment_ID
FROM SV00302
--ORDER BY Service_Call_ID, Equipment_ID

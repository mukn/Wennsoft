SELECT
	TRIM(Service_Call_ID) AS WO_number,
	TRIM(CUSTNMBR) AS Customer_code,
	TRIM(ADRSCODE) AS Location_code,
	TRIM(Divisions) AS Division,
	Billable_All,
	Billable_Equipment,
	Billable_Labor,
	Billable_Material,
	Billable_Other,
	Billable_Subs,
	Billable_Tax,
	Cost_All,
	Cost_Equipment,
	Cost_Labor,
	Cost_Material,
	Cost_Other,
	Cost_Subs

	--,*


FROM
	SV00300

-- This one is probably better for the costs
select * from SV000810 WHERE Service_Call_ID = '250623-0018'

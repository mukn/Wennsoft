-- Emergency service material costs, 13 months


-- ALTER VIEW Z_Report_Emergency_service_material_costs_13mo AS

SELECT 
	po.*
	,CASE
		WHEN PO_status = 1 THEN 'New'
		WHEN PO_status = 2 THEN 'Released'
		WHEN PO_status = 3 THEN 'Change order'
		WHEN PO_status = 4 THEN 'Received'
		WHEN PO_status = 5 THEN 'Closed'
		WHEN PO_status = 6 THEN 'Cancelled'
	END AS PO_status_str
	,emer.Division
FROM
(
SELECT
	h.PO_number
	--,l.PO_number
	,h.PO_status
	,h.Date_document
	,l.Work_number
	,l.Item_number
	,l.Item_description
	,l.Unit_measure
	,l.Unit_cost
	,l.Extended_cost
	,l.Cost_code
	,l.Cost_type

FROM
	(SELECT TRIM(PONUMBER) AS PO_number, CAST(DOCDATE AS date) AS Date_document, POSTATUS AS PO_status FROM POP10100) AS h
	LEFT OUTER JOIN
	(SELECT --top (1000)
		TRIM(JOBNUMBR) AS Work_number
		,TRIM(PONUMBER) AS PO_number
		,TRIM(ITEMNMBR) AS Item_number
		,TRIM(ITEMDESC) AS Item_description
		,UOFM AS Unit_measure
		,UMQTYINB
		,QTYORDER
		,UNITCOST AS Unit_cost
		,EXTDCOST AS Extended_cost
		,REQDATE AS Date_required
		,PRMDATE
		,PRMSHPDTE AS Date_shipped
		,Released_Date AS Date_released
		,ORIGPRMDATE
		,OPOSTSUB
		,TRIM(COSTCODE) AS Cost_code
		,COSTTYPE AS Cost_type
		FROM POP10110
	) AS l
		ON h.PO_number = l.PO_number

WHERE
	l.Work_number LIKE '[0-9][0-9][0-9][0-9][0-9][0-9]-%'	-- Removes jobs
	AND l.Cost_type = 2
	AND h.Date_document > GetDate() - 400					-- Limits to last year of data
	
	--h.PO_number <> l.PO_number	-- Filter proves that there are no mismatches between PO headers and line queries

UNION

SELECT
	h.PO_number
	--,l.PO_number
	,h.PO_status
	,h.Date_document
	,l.Work_number
	,l.Item_number
	,l.Item_description
	,l.Unit_measure
	,l.Unit_cost
	,l.Extended_cost
	,l.Cost_code
	,l.Cost_type

FROM
	(SELECT TRIM(PONUMBER) AS PO_number, CAST(DOCDATE AS date) AS Date_document, POSTATUS AS PO_status FROM POP30100) AS h
	LEFT OUTER JOIN
	(SELECT --top (1000)
		TRIM(JOBNUMBR) AS Work_number
		,TRIM(PONUMBER) AS PO_number
		,TRIM(ITEMNMBR) AS Item_number
		,TRIM(ITEMDESC) AS Item_description
		,UOFM AS Unit_measure
		,UMQTYINB
		,QTYORDER
		,UNITCOST AS Unit_cost
		,EXTDCOST AS Extended_cost
		,REQDATE AS Date_required
		,PRMDATE
		,PRMSHPDTE AS Date_shipped
		,Released_Date AS Date_released
		,ORIGPRMDATE
		,TRIM(COSTCODE) AS Cost_code
		,COSTTYPE AS Cost_type
		FROM POP30110
	) AS l
		ON h.PO_number = l.PO_number

WHERE
	l.Work_number LIKE '[0-9][0-9][0-9][0-9][0-9][0-9]-%'	-- Removes jobs
	AND l.Cost_type = 2
	AND h.Date_document > GetDate() - 400					-- Limits to last year of data
) AS po
	JOIN
	(SELECT TRIM(Divisions) AS Division,TRIM(Service_Call_ID) AS Work_number
		--,*
	FROM SV00300 WHERE TRIM(Divisions) LIKE '%_EMERG'
	) AS emer
		ON po.Work_number = emer.Work_number

--ORDER BY Date_document

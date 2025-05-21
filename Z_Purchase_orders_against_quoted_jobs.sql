/**
	This captures purchase orders opened against jobs, the vendor, date created, and total cost for analysis.
*/
SELECT 
	--TOP 1000 
	w.PO_number,
	w.Job_number,
	p.VENDORID AS Vendor_code,
	p.VENDNAME AS Vendor_name,
	p.CREATDDT AS Date_create,
	w.Cost_total
	--,w.*
	--,p.*
FROM
	(SELECT TRIM(PONUMBER) AS PO_number, TRIM(JOBNUMBR) AS Job_number, Actual_Total_Cost AS Cost_total
	FROM WS10101 GROUP BY PONUMBER,JOBNUMBR,Actual_Total_Cost) 
		AS w
	LEFT OUTER JOIN
	POP10100 AS p
		ON w.PO_number = TRIM(p.PONUMBER)
WHERE
	w.Job_number IN (SELECT TRIM(WS_Job_Number) FROM JC00102)

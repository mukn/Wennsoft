SELECT
	po.Purchasing_PO,
	p.Receipt_PO,
	po.Document_Date,
	po.PO_Status,
	po.PO_Status_Group,
	po.PO_Type,
	po.PO_subtotal,
	po.PO_tax,
	p.Invoice_number,
	p.Vendor_name,
	TRIM(d.TRXSORCE) AS Trx_source,
	g.ACTNUMBR_1 AS Account_number,
	d.ACTINDX AS GL_code,
	p.Receipt_number,
	p.Receipt_subtotal,
	p.Receipt_tax,
	d.CRDTAMNT,
	d.ORCRDAMT,
	d.DEBITAMT,
	d.ORDBTAMT
FROM
	(
	SELECT
		TRIM(p.PONUMBER) AS Purchasing_PO,
		p.DOCDATE AS Document_Date,
		CASE p.POSTATUS
			WHEN 1 THEN 'New'
			WHEN 2 THEN 'Released'
			WHEN 3 THEN 'Change order'
			WHEN 4 THEN 'Received'
			WHEN 5 THEN 'Closed'
			WHEN 6 THEN 'Cancelled'
		END AS PO_Status,
		CASE p.STATGRP
			WHEN 0 THEN 'Voided'
			WHEN 1 THEN 'Active'
			WHEN 2 THEN 'Closed'
		END AS PO_Status_Group,
		CASE p.POTYPE
			WHEN 1 THEN 'Standard'
			WHEN 2 THEN 'Drop ship'
			WHEN 3 THEN 'Blanket'
			WHEN 4 THEN 'Blanket drop ship'
		END AS PO_Type,
		p.SUBTOTAL AS PO_subtotal,
		p.TAXAMNT AS PO_tax
		--,*
	FROM
		POP10100 AS p
		UNION
	SELECT
		TRIM(p.PONUMBER) AS Purchasing_PO,
		p.DOCDATE AS Document_Date,
		CASE p.POSTATUS
			WHEN 1 THEN 'New'
			WHEN 2 THEN 'Released'
			WHEN 3 THEN 'Change order'
			WHEN 4 THEN 'Received'
			WHEN 5 THEN 'Closed'
			WHEN 6 THEN 'Cancelled'
		END AS PO_Status,
		CASE p.STATGRP
			WHEN 0 THEN 'Voided'
			WHEN 1 THEN 'Active'
			WHEN 2 THEN 'Closed'
		END AS PO_Status_Group,
		CASE p.POTYPE
			WHEN 1 THEN 'Standard'
			WHEN 2 THEN 'Drop ship'
			WHEN 3 THEN 'Blanket'
			WHEN 4 THEN 'Blanket drop ship'
		END AS PO_Type,
		p.SUBTOTAL AS PO_subtotal,
		p.TAXAMNT AS PO_tax
		--,*
	FROM
		POP30100 AS p
	) AS po
	LEFT OUTER JOIN
	(
		SELECT 
			TRIM(r.POPRCTNM) AS Receipt_number,
			h.RCPTLNNM AS Receipt_LineNumber,
			TRIM(h.PONUMBER) AS Receipt_PO,
			TRIM(r.VNDDOCNM) AS Invoice_number,
			h.TRXSORCE AS Trx_source,
			r.VENDNAME AS Vendor_name,
			SUM(h.EXTDCOST) AS Receipt_subtotal,
			SUM(h.TAXAMNT) AS Receipt_tax
		FROM POP30300 AS r
		LEFT OUTER JOIN 
		POP30310 AS h 
			ON TRIM(r.POPRCTNM) = TRIM(h.POPRCTNM)
		GROUP BY 
			TRIM(r.POPRCTNM), 
			TRIM(h.PONUMBER),
			h.RCPTLNNM,
			TRIM(r.VNDDOCNM), 
			h.TRXSORCE, 
			r.VENDNAME
	) AS p
		ON po.Purchasing_PO = p.Receipt_PO
	LEFT OUTER JOIN
	POP30390 AS d
		ON
			p.Receipt_number = d.POPRCTNM
			AND p.Trx_source = TRIM(d.TRXSORCE)
			AND p.Receipt_LineNumber = d.SEQNUMBR
	LEFT OUTER JOIN
	GL00100 AS g
		ON d.ACTINDX = g.ACTINDX
WHERE
	--p.Receipt_PO = 'PO0099001' AND                        -- For qc
	(g.ACTINDX = 40 OR g.ACTINDX = 42)
ORDER BY
	Purchasing_PO ASC,
	Receipt_number

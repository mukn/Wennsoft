SELECT
    TRIM(po.PONUMBER) AS Purchasing_PO,
    rc.Receipt_PO,
    po.DOCDATE AS Document_Date,
    CASE po.POSTATUS
        WHEN 1 THEN 'New'
        WHEN 2 THEN 'Released'
        WHEN 3 THEN 'Change order'
        WHEN 4 THEN 'Received'
        WHEN 5 THEN 'Closed'
        WHEN 6 THEN 'Cancelled'
    END AS PO_Status,
    CASE po.STATGRP
        WHEN 0 THEN 'Voided'
        WHEN 1 THEN 'Active'
        WHEN 2 THEN 'Closed'
    END AS PO_Status_Group,
    CASE po.POTYPE
        WHEN 1 THEN 'Standard'
        WHEN 2 THEN 'Drop ship'
        WHEN 3 THEN 'Blanket'
        WHEN 4 THEN 'Blanket drop ship'
    END AS PO_Type,
    po.SUBTOTAL AS PO_subtotal,
    po.TAXAMNT AS PO_tax,
    rc.Invoice_number,
    rc.Vendor_name,
    rc.Trx_source,
    rc.Receipt_number,
    rc.Receipt_subtotal,
    rc.Receipt_tax

FROM dbo.POP10100 AS po
  LEFT OUTER JOIN 
    (
      SELECT 
          TRIM(r.POPRCTNM) AS Receipt_number,
          TRIM(r.PONUMBER) AS Receipt_PO,
          TRIM(h.VNDDOCNM) AS Invoice_number,
          h.TRXSORCE AS Trx_source,
          h.VENDNAME AS Vendor_name,
          SUM(r.EXTDCOST) AS Receipt_subtotal,
          SUM(r.TAXAMNT) AS Receipt_tax
      FROM dbo.POP30310 AS r
      LEFT OUTER JOIN dbo.POP30300 AS h 
          ON TRIM(r.POPRCTNM) = TRIM(h.POPRCTNM)
      GROUP BY 
          TRIM(r.POPRCTNM), 
          TRIM(r.PONUMBER), 
          TRIM(h.VNDDOCNM), 
          h.TRXSORCE, 
          h.VENDNAME
    ) AS rc 
      ON TRIM(po.PONUMBER) = rc.Receipt_PO
  RIGHT OUTER JOIN 
    (
      SELECT
          TRIM(d.POPRCTNM) AS Receipt_number,
          d.ACTINDX AS GL_index,
          g.ACTNUMBR_1
      FROM POP30390 AS d
      LEFT OUTER JOIN GL00100 AS g 
          ON d.ACTINDX = g.ACTINDX
      WHERE g.ACTINDX = 42
    ) AS gl 
      ON gl.Receipt_number = rc.Receipt_number

ORDER BY 
    Purchasing_PO DESC, 
    rc.Receipt_number;

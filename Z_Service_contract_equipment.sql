SELECT
	--TOP 100
	ce.Location_code,
	ce.Customer_code,
	ce.Contract_code,
	ce.Equipment_code,
	--TRIM(e.Equipment_ID) AS Equipment_code,
	TRIM(e.Equipment_Type) AS Equipment_label,
	TRIM(e.Manufacturer_ID) AS Make,
	TRIM(e.Wennsoft_Model_Number) AS Model_number,
	TRIM(e.Wennsoft_Serial_Number) AS Serial_Number,
	CASE
		WHEN e.Install_Date = '1900-01-01' THEN NULL
		ELSE e.Install_Date
	END AS Date_install,
	TRIM(e.Equipment_Description2) AS Equipment_desc,
	e.RefrigerantTypeID,
	e.RefrigerantEquipmentType,
	TRIM(e.SV_Building_Room) AS Equipment_location
	--,'',e.*
FROM
	(SELECT TRIM(CUSTNMBR) AS Customer_code, TRIM(ADRSCODE) AS Location_code, TRIM(Contract_number) AS Contract_code, TRIM(Equipment_ID) AS Equipment_code
	FROM SV00403) AS ce
	LEFT OUTER JOIN
	SV00400 AS e
		ON 
		--ce.Customer_code = TRIM(e.CUSTNMBR) AND 
		ce.Location_code = TRIM(e.ADRSCODE) AND 
		--ce.Contract_code = TRIM(e.Contract_Number)
		ce.Equipment_code = TRIM(e.Equipment_ID)
WHERE
	--ce.Contract_code = '121CONGR23' AND
	e.Equipment_ID <> 'HOURS'	-- Exclude hours which are used for tasking
ORDER BY
	ce.Contract_code, ce.Equipment_code

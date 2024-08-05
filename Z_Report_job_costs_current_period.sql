-- This provides a list of costs aggregated by job & date of cost.
SELECT
	TRIM(j.WS_Job_Number) AS Job_Number
	--,j.Job_TRX_Number
	,j.DOCDATE AS DOCDATE
	--,j.DOCAMNT
	,SUM(j.Cost_Code_Act_Cost_TTD) AS Cost
	--,TRIM(j.Cost_Code_Description) AS Cost_Description

  -- Split costs into costs from current month (1) and previous months (0)
	,CASE
		WHEN YEAR(j.DOCDATE) = YEAR(CURRENT_TIMESTAMP)
			AND MONTH(j.DOCDATE) = MONTH(CURRENT_TIMESTAMP)
			THEN 1
		ELSE 0
	END AS Is_Current_Period
  -- Costs job to date excluding previous costs
	,CASE
		WHEN YEAR(j.DOCDATE) = YEAR(CURRENT_TIMESTAMP)
			AND MONTH(j.DOCDATE) = MONTH(CURRENT_TIMESTAMP)
			THEN 0
		ELSE SUM(j.Cost_Code_Act_Cost_TTD)
	END AS Prior_JTD
  -- Costs month to date
	,CASE
		WHEN YEAR(j.DOCDATE) = YEAR(CURRENT_TIMESTAMP)
			AND MONTH(j.DOCDATE) = MONTH(CURRENT_TIMESTAMP)
			THEN SUM(j.Cost_Code_Act_Cost_TTD)
		ELSE 0
	END AS MTD

FROM
	JC20001 AS j

GROUP BY
	j.WS_Job_Number
	,j.DOCDATE
	--,j.Cost_Code_Description

--ORDER BY 
--	DOCDATE DESC

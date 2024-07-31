-- Job cost report for sales managers
-- THis is a collection of all active jobs with information about the associated costs.

SELECT
  j.Job_Number -- Job Number
  ,j.Job_Description -- Job Description
  ,j.SalesRep_Number AS SalesRep -- Sales rep
  ,j.PM_Number AS PM -- PM

  
-- Cost Type
-- Est Cost
-- Est Hours
-- Foreman
-- JTD Cost
-- JTD Hours
-- Cost percent complete

-- Projected Cost
-- Projected Hours



-- The following are calculated
----Completion
----Current Cost/HR
----Projected Rate
----Remaining Cost
----Remaining Hours

	--,j.*

FROM
  Z_Active_jobs AS j

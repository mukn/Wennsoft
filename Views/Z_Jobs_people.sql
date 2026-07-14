--ALTER VIEW Z_jobs_people AS
SELECT
  j.Job_number
  ,TRIM(p.WS_Manager_ID) AS PM_code
  ,p.Estimator_ID AS SalesRep_code
  ,u.Foreman AS Foreman_code
  
FROM
  Z_Jobs_metadata AS j
  LEFT OUTER JOIN
  Z_All_jobs_udfs AS u
    ON j.Job_number = u.Job_number 
  LEFT OUTER JOIN
  JC00102 AS p
    ON j.Job_number = p.WS_Job_Number

SELECT
  CAST(t.EMPLOYID AS int) AS EmployeeID,
  t.Technician AS TechnicianID,
  t.Technician_Long_Name AS EmployeeName,
  c.INET1 AS EmployeeEmail,
  TRIM(t.Technician_Team) AS Team,
  m.TeamLead_name AS TeamLeadName,
  m.TeamLead_email AS TeamLeadEmail,
  m.Dispatcher_name AS DispatcherName,
  m.Dispatcher_email AS DispatcherEmail
FROM
  SV00115 AS t LEFT OUTER JOIN
  SY01200 AS c
    ON t.EMPLOYID = c.Master_ID
  LEFT OUTER JOIN
  Z_Technician_teams AS m
    ON t.Technician_Team = m.Team
WHERE  (t.SV_Inactive = 0)

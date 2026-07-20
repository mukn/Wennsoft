foreach ($c in $csv[51..119]) {
  $job = $c.Job
  $pm = ''
  if ($c.pm) {$pm = $c.PM}
  $super = ''
  if ($c.super) {$super = $c.Super}
  $start = ''
  if ($c.start) {$start = (Get-Date).ToString($c.Start)}
  $end = ''
  if ($c.end) {$end = (Get-Date).ToString($c.End)}
  
  Write-Host "Updating $job details: PM = $pm, Superintendent = $super, Start scheduled = $start, Complete scheduled = $end"
  Invoke-Sqlcmd -ServerInstance k2a.nacgroup.com -Database NAC -TrustServerCertificate `
    -Query " SELECT WS_Job_Number, WS_Manager_ID, Schedule_Start_Date, Sched_Completion_Date FROM JC00102 WHERE WS_Job_Number = '$job'
    SELECT WS_Job_Number, WS_Manager_ID_2 FROM JC00107 WHERE WS_Job_Number = '$job' "
  
  Invoke-Sqlcmd -ServerInstance k2a.nacgroup.com -Database NAC -TrustServerCertificate `
    -Query " UPDATE JC00102 SET WS_Manager_ID = $pm, Schedule_Start_Date = '$start', Sched_Completion_Date = '$end' WHERE WS_Job_Number = '$job'
    UPDATE JC00107 SET WS_Manager_ID_2 = $super WHERE WS_Job_Number = '$job' "
  
  Write-Host "The updated values are: "
  Invoke-Sqlcmd -ServerInstance k2a.nacgroup.com -Database NAC -TrustServerCertificate `
    -Query " SELECT WS_Job_Number, WS_Manager_ID, Schedule_Start_Date, Sched_Completion_Date FROM JC00102 WHERE WS_Job_Number = '$job' "
  Invoke-Sqlcmd -ServerInstance k2a.nacgroup.com -Database NAC -TrustServerCertificate `
    -Query " SELECT WS_Job_Number, WS_Manager_ID_2 FROM JC00107 WHERE WS_Job_Number = '$job' "
  
}

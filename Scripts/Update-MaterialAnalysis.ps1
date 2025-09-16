<##  This is a simple script used to update the material analysis fields in Wennsoft.
    This requires a csv file fields for JobNumber, Reason, and Notes. The reasons must 
    be validated as follows:

    Diff mat (bad ops decision)
    Diff mat (good ops decision)
    Good list, better buy
    Good material list, no quote
    Incomplete material list
    Incorrect cost code
    Material charged to wrong job
    Material list is not adequate
    Missed CO
    No bid on materials
    Other (explain in notes)
    Over-estimated materials
    Price escalation after award
    T&M converted to quoted job
    We overbuilt the project

    #>

$material = Import-Csv .\MaterialAnalysis.csv

foreach ($m in $material) {
  $job = $m.JobNumber.Trim(); $reason = $m.Reason; $notes = $m.Notes
  Invoke-Sqlcmd -ServerInstance k2a.nacgroup.com -Database NAC `
  -Query "INSERT INTO cstb_JobUDF4Reasons (WS_Job_Number, Reason, Notes) VALUES ('$job', '$reason', '$notes')" `
  -TrustServerCertificate
}


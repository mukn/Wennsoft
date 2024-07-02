<#
This should be inserted into Connect-Wennsoft.ps1 to update a project manager for a given job.

Returns a string with the query necessary to update a given job with a project manager.
#>

param (
  [Parameter(Mandatory=$True)]
  [string]$Job_Number,
  [Parameter(Mandatory=$True)]
  [int]$PM
)

$WS_Job_Number = $Job_Number
$WS_Manager_ID = $PM

$qry = "UPDATE JC00102 SET WS_Manager_ID = '$WS_Manager_ID' WHERE WS_Job_Number = '$WS_Job_Number'"
return $qry

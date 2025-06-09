function Remove-TimeBatch {
  <#
  This should be inserted into Connect-Wennsoft.ps1 to remove a given time batch.
  
  Removes a time batch based on name.
  #>
  
  param (
    [Parameter(Mandatory=$True)]
    [string]$batchName
  )
  
  $batchId = $batchName
  
  $qry = "DELETE FROM UPR10304 WHERE BACHNUMB = '$batchId'"
  return $qry
}

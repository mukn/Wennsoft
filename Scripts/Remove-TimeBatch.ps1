function Remove-TimeBatch {
  <#
  This should be inserted into Connect-Wennsoft.ps1 to remove a given time batch.
  
  Removes a time batch based on name.

  Notes:
  DECLARE @batchId varchar(30);
  SET @batchId = '';
  DELETE FROM UPR10304 WHERE BACHNUMB = @batchId;
  GO

  
  #>
  
  param (
    [Parameter(Mandatory=$True)]
    [string]$batchName
  )
  
  $batchId = $batchName
  
  $qry = "DELETE FROM UPR10304 WHERE BACHNUMB = '$batchId'"
  return $qry
}

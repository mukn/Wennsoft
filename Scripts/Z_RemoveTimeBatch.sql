/**      Z_RemoveTimeBatch
  
  Removes a time batch based on name. Place the batch name into the variable.
  
  */
  
DECLARE @batchId varchar(30);
  SET @batchId = '';
  DELETE FROM DYNAMICS.dbo.UPR10304 WHERE BACHNUMB = @batchId;
  GO

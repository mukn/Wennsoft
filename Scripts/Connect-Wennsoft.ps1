<#
Some of this was taken from https://gist.github.com/yi7/52083ca879bbe14aee9f5932f8320135 and some from https://stackoverflow.com/q/62526119. 

#>

# Build the connection string variables.
$sqlServer = Read-Host "Server name"
$sqlDB = Read-Host "Database"
#$sqlTable = "table"
$uid = Read-Host "Username"
$sqlPwd = Read-Host "Password" -AsSecureString

# Create the connection.
$sqlConn = New-Object System.Data.SqlClient.SqlConnection
$sqlConn.ConnectionString = "Server = $sqlServer; Database = $sqlDB; User ID = $uid; Password = $sqlPwd;Integrated Security=true"
$sqlCmd = New-Object System.Data.SqlClient.SqlCommand
$sqlConn.Open()
$sqlCmd.Connection = $sqlConn

# Create the command
$sqlcmd = New-Object System.Data.SqlClient.SqlCommand
$sqlcmd.Connection = $sqlConn
$query = " --INSERT THE COMMAND HERE-- "
$sqlcmd.CommandText = $query

# Create the data adapter
$adp = New-Object System.Data.SqlClient.SqlDataAdapter $sqlcmd

# Create and retreive the data
$data = New-Object System.Data.DataSet
$adp.Fill($data) | Out-Null
$data.Tables

# Close the connection.
$sqlConn.Close()

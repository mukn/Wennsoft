function Test-LiaisonPrinterExists {
  $liaisonShare = "\\nac-k2a-23\LiaisonEDD\"
  $liaisonPrinters = Get-Printer | Where-Object DriverName -eq "Amyuni Document Converter 550"
  $liaisonFlag = ($liaisonPrinters.Length -eq 2)
  $liaisonAccess = Test-Path -Path $liaisonShare
  
  if ($liaisonFlag -and $liaisonAccess) {
    Write-Host "Liaison is installed and accessible."
    $level = "Success"
    } else {
    Write-Host "Liaison is not functional."
    $level = "Error"
    }
}

function Invoke-ItEventLog {
  param (
    [Parameter(Mandatory=$true)]
    [string[]] $Source,
    [Parameter(Mandatory=$true)]
    [string[]] $Description,
    [Parameter(Mandatory=$true)]
    [ValidateSet("Success", "Info", "Error")]
    [string[]] $Level = "Info"
  )

  # Construct JSON payload
  $payload = @{
      Source = $source
      Description = $description
      Level = $level
  } | ConvertTo-Json -Depth 3

  Write-Host $payload
  # Send to API
  $apiUrl = "https://prod-186.westus.logic.azure.com:443/workflows/9b2f66732e064b8f9d687635457fa80e/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=7_lhK5UoUu7aOy3xU-C4kQHXI7FzSuda-rDwsvcN1fk"
  Invoke-RestMethod -Uri $apiUrl -Method Post -Body $payload -ContentType "application/json"
}

# Script variables
$source = "Liaison printer service test"
$hostname = $env:COMPUTERNAME
$description = "Liaison printer service test on $hostname"

# Run test
Test-LiaisonPrinterExists

# Send info to IT event log
Invoke-ItEventLog -Source $source -Description $description -Level $level

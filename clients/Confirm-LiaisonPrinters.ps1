
$liaisonShare = \\nac-k2a-23\LiaisonEDD\
$liaisonPrinters = Get-Printer| Where-Object DriverName -eq "Amyuni Document Converter 550"
$liaisonFlag = ($liaisonPrinters.Length -eq 2)
$liaisonAccess = Test-Path -Path $liaisonShare

if ($liaisonFlag -and $liaisonAccess) {
  Write-Host "Liaison is installed and accessible."
  } else {
  Write-Host "Liaison is not functional."
  }

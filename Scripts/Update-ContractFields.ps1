$csvFile = ""
$csvData = Import-Csv -Path $csvFile

function Update-ContractFields {
    param(
        [string]$Server = "k2a.nacgroup.com",
        [string]$Database = "NAC",
        [string]$Contract,
    
        [Nullable[float]]$EstCost,
        [Nullable[float]]$EstLabor,
        [Nullable[int]]$EstHours,
        [Nullable[float]]$EstLabor1,
        [Nullable[int]]$EstHours1,
        [Nullable[float]]$EstLabor2,
        [Nullable[int]]$EstHours2,
        [Nullable[float]]$EstMat,
    
        [Nullable[float]]$ForCost,
        [Nullable[float]]$ForLabor,
        [Nullable[int]]$ForHours,
        [Nullable[float]]$ForLabor1,
        [Nullable[int]]$ForHours1,
        [Nullable[float]]$ForLabor2,
        [Nullable[int]]$ForHours2,
        [Nullable[float]]$ForMat
        #New-Item -Name "ContractUpdate.log" -Path ~\Downloads
        #[string]$LogFile = Get-Item -Name "ContractUpdate.log" -Path ~\Downloads
    )
    
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    
    # Fetch existing record
    $querySelect = @"
    SELECT TOP 1 *
    FROM SV00500
    WHERE Contract_Number = '$Contract'
    "@
    
    $existing = Invoke-Sqlcmd -ServerInstance $Server -Database $Database -Query $querySelect -Encrypt Optional
    
    if ($existing) {
        $changes = @{}
    
        # Only update if parameter was provided AND value differs
        if ($PSBoundParameters.ContainsKey('EstCost') -and $existing.Estimate_Total_Cost -ne $EstCost) { $changes["Estimate_Total_Cost"] = $EstCost }
        if ($PSBoundParameters.ContainsKey('EstLabor') -and $existing.Estimate_Labor -ne $EstLabor) { $changes["Estimate_Labor"] = $EstLabor }
        if ($PSBoundParameters.ContainsKey('EstHours') -and $existing.Estimate_Hours -ne $EstHours) { $changes["Estimate_Hours"] = $EstHours }
        if ($PSBoundParameters.ContainsKey('EstLabor1') -and $existing.Estimate_Labor_1 -ne $EstLabor1) { $changes["Estimate_Labor_1"] = $EstLabor1 }
        if ($PSBoundParameters.ContainsKey('EstHours1') -and $existing.Estimate_Labor_1_Hours -ne $EstHours1) { $changes["Estimate_Labor_1_Hours"] = $EstHours1 }
        if ($PSBoundParameters.ContainsKey('EstLabor2') -and $existing.Estimate_Labor_2 -ne $EstLabor2) { $changes["Estimate_Labor_2"] = $EstLabor2 }
        if ($PSBoundParameters.ContainsKey('EstHours2') -and $existing.Estimate_Labor_2_Hours -ne $EstHours2) { $changes["Estimate_Labor_2_Hours"] = $EstHours2 }
        if ($PSBoundParameters.ContainsKey('EstMat') -and $existing.Estimate_Material -ne $EstMat) { $changes["Estimate_Material"] = $EstMat }
    
        if ($PSBoundParameters.ContainsKey('ForCost') -and $existing.Forecast_Total_Cost -ne $ForCost) { $changes["Forecast_Total_Cost"] = $ForCost }
        if ($PSBoundParameters.ContainsKey('ForLabor') -and $existing.Forecast_Labor -ne $ForLabor) { $changes["Forecast_Labor"] = $ForLabor }
        if ($PSBoundParameters.ContainsKey('ForHours') -and $existing.Forecast_Hours -ne $ForHours) { $changes["Forecast_Hours"] = $ForHours }
        if ($PSBoundParameters.ContainsKey('ForLabor1') -and $existing.Forecast_Labor_1 -ne $ForLabor1) { $changes["Forecast_Labor_1"] = $ForLabor1 }
        if ($PSBoundParameters.ContainsKey('ForHours1') -and $existing.Forecast_Labor_1_Hours -ne $ForHours1) { $changes["Forecast_Labor_1_Hours"] = $ForHours1 }
        if ($PSBoundParameters.ContainsKey('ForLabor2') -and $existing.Forecast_Labor_2 -ne $ForLabor2) { $changes["Forecast_Labor_2"] = $ForLabor2 }
        if ($PSBoundParameters.ContainsKey('ForHours2') -and $existing.Forecast_Labor_2_Hours -ne $ForHours2) { $changes["Forecast_Labor_2_Hours"] = $ForHours2 }
        if ($PSBoundParameters.ContainsKey('ForMat') -and $existing.Forecast_Material -ne $ForMat) { $changes["Forecast_Material"] = $ForMat }
    
        if ($changes.Count -gt 0) {
            $setClause = ($changes.Keys | ForEach-Object { "$_ = $($changes[$_])" }) -join ", "
            $queryUpdate = @"
    BEGIN TRAN;
    UPDATE SV00500 SET $setClause WHERE Contract_Number = '$Contract';
    COMMIT TRAN;
    "@
    
            try {
                Invoke-Sqlcmd -ServerInstance $Server -Database $Database -Query $queryUpdate -Encrypt Optional
                $logEntry = "$timestamp | Contract: $Contract | Updated Fields: $($changes.Keys -join ', ')"
                #Add-Content -Path $LogFile -Value $logEntry
                Write-Host "Update successful. Changes logged to $LogFile"
            }
            catch {
                Invoke-Sqlcmd -ServerInstance $Server -Database $Database -Query "ROLLBACK TRAN;" -Encrypt Optional
                $logEntry = "$timestamp | Contract: $Contract | ERROR: $($_.Exception.Message)"
                #Add-Content -Path $LogFile -Value $logEntry
                Write-Host "Update failed. Rolled back transaction. Error logged."
            }
        } else {
            Write-Host "No changes detected for contract $Contract."
            #Add-Content -Path $LogFile -Value "$timestamp | Contract: $Contract | No changes detected."
        }
    } else {
        Write-Host "No record found for contract $Contract."
        #Add-Content -Path $LogFile -Value "$timestamp | Contract: $Contract | Record not found."
    }
}

foreach ($c in $csvData) {
    # Define temporary variables
    $ContractNumber = $c.ContractNumber
    $EstimateMaterial = $c.EstimateMaterial
    $EstimateTotalCost = $c.EstimateTotalCost
    $EstimateTotalLabor = $c.EstimateTotalLabor
    $EstimateTotalLaborHrs = $c.EstimateTotalLaborHrs
    $EstimateLabor1 = $c.EstimateLabor1
    $EstimateLabor1Hours = $c.EstimateLabor1Hours
    $EstimateLabor2 = $c.EstimateLabor2
    $EstimateLabor2Hours = $c.EstimateLabor2Hours
    $ForecastMaterial = $c.ForecastMaterial
    $ForecastTotalCost = $c.ForecastTotalCost
    $ForecastTotalLabor = $c.ForecastTotalLabor
    $ForecastTotalLaborHrs = $c.ForecastTotalLaborHrs
    $ForecastLabor1 = $c.ForecastLabor1
    $ForecastLabor1Hours = $c.ForecastLabor1Hours
    $ForecastLabor2 = $c.ForecastLabor2
    $ForecastLabor2Hours = $c.ForecastLabor2Hours

    # Run the update(s)
    Update-ContractFields
        -Contract $ContractNumber `
        -EstMat $EstimateMaterial -EstCost $EstimateTotalCost `
        -EstLabor $EstimateTotalLabor -EstHours $EstimateTotalLaborHrs `
        -EstLabor1 $EstimateLabor1 -EstHours1 $EstimateLabor1Hours ` 
        -EstLabor2 $EstimateLabor2 -EstHours2 $EstimateLabor2Hours `
        -ForMat $ForecastMaterial -ForCost $ForecastTotalCost `
        -ForLabor $ForecastTotalLabor -ForHours $ForecastTotalLaborHrs `
        -ForLabor1 $ForecastLabor1 -ForHours1 $ForecastLabor1Hours `
        -ForLabor2 $ForecastLabor2 -ForHours2 $ForecastLabor2Hours

}

$databases = @("CRM", "Nurses", "Giftcard", "Opps", "ERP")

foreach ($database in $databases) {
    try {
        & "flyway" -configFile="$database/flyway.conf" migrate
    }
    catch {
        $errorMsg = $_.Exception.Message
        if ($errorMsg -match "Invalid object name") {
            Write-Host "Skipping $database due to missing dependencies"
        }
        else {
            throw $_
        }
    }
}

# loop back to any failed databases
$faileddatabases = @()
foreach ($database in $databases) {
    try {
        & "flyway" -configFile="$database/flyway.conf" migrate
    }
    catch {
        $faileddatabases += $database
    }
}

if ($faileddatabases.Count -gt 0) {
    Write-Host "Failed to deploy the following databases:"
    Write-Host $faileddatabases
    exit 1
}

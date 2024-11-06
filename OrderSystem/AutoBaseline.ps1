## Set the working folder path
$workingFolderPath = "C:\WorkingFolders\test"

# Set the database type and database connection properties
$databaseType = "Oracle" # alt values: SqlServer Oracle PostgreSql 
$Url = "jdbc:oracle:thin:@//localhost:1521/Dev1"
$User = "userName"
$Password = "Password"

# Set the tablespace name
$TableSpaceName = "TableSpaceName"

# Set the schemas value
$schemas = @("SchemaName") # can be empty for SqlServer

# Set the artifact and migration paths
$artifactPath = Join-Path $workingFolderPath "artifact.zip"
$migrationPath = Join-Path $workingFolderPath "migrations"

# Create a project (SQL Server)
flyway-dev init -n Autobaseline -p $workingFolderPath --database-type $databaseType --i-agree-to-the-eula

# Read the JSON file
$jsonPath = Join-Path $workingFolderPath "flyway-dev.json"
$json = Get-Content -Path $jsonPath | ConvertFrom-Json

# Add a new key-value pair to the JSON
$newKey = "schemas"
$newValue = $schemas
$json | Add-Member -MemberType NoteProperty -Name $newKey -Value $newValue

$devDB = @{
    "connectionProvider" = @{
        "type" = "UsernamePassword"
        "url" = "some-url"
    }
}

$json | Add-Member -MemberType NoteProperty -Name "developmentDatabase" -Value $devDB

if ($databaseType -eq "Oracle") {
    $capabilities = @{
        "comparison" = @{
            "options" = @{
                "IncludeStorageTablespace" = $true
            }
        }
    }

    $json | Add-Member -MemberType NoteProperty -Name "capabilities" -Value $capabilities
}
    # Write out the updated JSON
    $json | ConvertTo-Json -Depth 100 | Set-Content -Path $jsonPath

    # Get the differences from Production
    $diffOptions = @{
        "url" = $Url
        "user" = $User
        "password" = $Password
        "token" = $null
        "schemas" = $schemas
        "resolverProperties" = @()
    }

    $diffOptions | ConvertTo-Json | flyway-dev diff -p $workingFolderPath -a $artifactPath --from Target --to Empty --output json --i-agree-to-the-eula

    # Generate the baseline from all differences
    flyway-dev take -p $workingFolderPath -a $artifactPath --i-agree-to-the-eula | flyway-dev generate -p $workingFolderPath -a $artifactPath -o $migrationPath --name 'B1__baseline.sql' --versioned-only --i-agree-to-the-eula

if ($databaseType -eq "Oracle") {
    # Append script to B1__baseline.sql
    $scriptPath = Join-Path $migrationPath 'B1__baseline.sql'
    $scriptTempPath = Join-Path $migrationPath 'B1__baseline_temp.sql'
    $scriptContent = @"
-- Add your script content here
SET DEFINE OFF
ALTER USER $schemas QUOTA UNLIMITED ON $TableSpaceName;
ALTER USER $schemas DEFAULT TABLESPACE $TableSpaceName;

"@

    # Output the script content to a file with UTF-8 encoding
    $scriptContent | Out-File -Encoding UTF8 -FilePath $scriptTempPath

    Get-Content -Path $scriptPath | Add-Content -Path $scriptTempPath
    Remove-Item -Path $scriptPath
    Rename-Item -Path $scriptTempPath -NewName $scriptPath
}

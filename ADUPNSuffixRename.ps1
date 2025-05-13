$newDomain = "fooltime.com"
$oldDomain = "foolhire.com"

# Just some visual representation of CSV info
$csvData = @"
SamAccountName,CurrentUPN
jdoe,jdoe@foolhire.com
asmith,asmith@foolhire.com
... etc ...
"@ | ConvertFrom-Csv

foreach ($user in $csvData) {
    $newUPN = $user.CurrentUPN -replace $oldDomain, $newDomain

    try {
        Set-ADUser -Identity $user.SamAccountName `
            -UserPrincipalName $newUPN `
            -EmailAddress $newUPN

        Write-Host "AD updated: $($user.SamAccountName) -> $newUPN"
    }
    catch {
        Write-Warning "Failed to update AD for $($user.SamAccountName): $_"
    }
}

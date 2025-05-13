Connect-ExchangeOnline

foreach ($user in $csvData) {
    $oldEmail = $user.CurrentUPN
    $newEmail = $oldEmail -replace $oldDomain, $newDomain

    try {
        # Add new primary, keep old as alias
        Set-Mailbox -Identity $user.SamAccountName `
            -EmailAddresses @{Add="SMTP:$newEmail"; Remove=$oldEmail}

        Write-Host "Exchange updated: $($user.SamAccountName) -> $newEmail"
    }
    catch {
        Write-Warning "Failed Exchange update for $($user.SamAccountName): $_"
    }
}

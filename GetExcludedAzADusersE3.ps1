#Script to filter active AAD users using an exclusion list, then filter results showing only E3 licensed# 
####Prerequisites####
Connect-AzureAD
Connect-MsolService
#####################

# Define the locations to exclude
$excludedlist = @("NJ-Gibbstown","NJ-Cherry Hill","NJ-Bridgeport","PA-Myerstown","NJ-Cinnaminson","NJ-Gibbstown, NJ-Cherry Hill")

# Get all Azure AD users who are members with enabled accounts
$users = Get-AzureADUser -All $true | Where-Object {$_.UserType -eq 'Member' -and $_.AccountEnabled -eq $true}

# Filter users based on the physicaldeliveryofficename
$filteredUsers = $users | Where-Object {
    $_.PhysicalDeliveryOfficeName -notin $excludedlist -or $_.PhysicalDeliveryOfficeName -eq $null
}

# Pipe the results with a query to see which of the users in $filteredusers has an E3 license
$filteredUsers | Get-MsolUser | Where-Object {($_.licenses).AccountSkuId -match "SPE_E3" } | Select-Object UserPrincipalName, DisplayName, isLicensed | Export-Csv -Path "c:\temp\excluserlist2.csv" -NoTypeInformation
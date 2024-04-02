#Script to list all active azure ad users and export to csv# 
Connect-AzureAD
###

# Get all Azure AD users who are "members" and have enabled accounts
$EnabledAccounts = Get-AzureADUser -All $true | Where-Object { $_.AccountEnabled -eq $true -and $_.UserType -eq "Member" }

# Display the user information
$EnabledAccounts | Select-Object DisplayName, UserPrincipalName, accountEnabled | export-csv c:\azure-1.csv -NoTypeInformation
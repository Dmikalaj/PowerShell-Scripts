#Script to list/export to csv all enabled users in AzureAD and display their office location # 
Connect-AzureAD
###

$AllUsers = Get-AzureADUser -All $true | Where-Object { $_.AccountEnabled -eq $true -and $_.UserType -eq "Member" }

$allusers | Where-Object {$_.physicalDeliveryOfficeName -eq "NJ-Gibbstown"} | Select-Object DisplayName,physicalDeliveryOfficeName | Export-Csv -path 'c:\temp\UsersWithOfficeLocations.csv'
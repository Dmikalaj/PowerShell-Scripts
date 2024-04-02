#Script to list all azuread joined machines that have not been active for more than 2 months# 

####Prerequisites####
Connect-AzureAD
###

$azureMachines = Get-AzureADDevice -All $true | Where-Object {$_.DeviceTrustType -eq "AzureAD"} | Select-Object -Property DisplayName, ApproximateLastLogonTimeStamp, objectid
$inactiveMachines = $azureMachines | Where-Object {($_.ApproximateLastLogonTimeStamp -lt (Get-Date).AddDays(-60))}

$inactiveMachines | Export-Csv -Path 'C:\Temp\InactiveAADjoinedMachines1.csv' -NoTypeInformation

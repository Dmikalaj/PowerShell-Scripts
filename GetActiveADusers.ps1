#script to get all enabled accounts in AD/ export to csv for review
###Prerequisites###
Import-Module ActiveDirectory
###

$enabledaccounts = get-aduser -filter * | Where-Object {$_.enabled -eq $true} 

$enabledaccounts | Select-Object UserPrincipalName,name, displayname | export-csv c:\temp\ad1.csv -NoTypeInformation
#Script to get all the members/email addresses of a security group in azure
Connect-AzureAD
###
Get-AzureADGroup -ObjectId 'OBJECTID' | Get-AzureADGroupMember -All $True  | Export-Csv -path 'c:\temp\emails.csv'

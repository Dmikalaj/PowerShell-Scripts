#Script to get all the email addresses of the members of a security group in azure
Connect-AzureAD
###
Get-AzureADGroupMember -ObjectId "" | select mail | Export-Csv -path 'c:\temp\emails.csv'
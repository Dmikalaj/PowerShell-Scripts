#Specify a username to get a list of all Active Directory groups they belong to

Get-ADPrincipalGroupMembership "USERNAME" | get-adgroup -property description, groupcategory | select-object name, groupcategory, description | Sort-Object groupcategory, name | Export-Csv -path 'C:\temp\usergroups.csv' -NoTypeInformation

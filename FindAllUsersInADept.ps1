#Script to obtain a list of all users in a department using a keyword
Connect-AzureAD
###
get-azureaduser -all $true | Where-Object {$_.department -like '*3D*'}
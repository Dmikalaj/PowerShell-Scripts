#Script to update the company attribute in AD using a CSV file# 

####Prerequisites####
Import-Module ActiveDirectory
###
# Import the CSV file
$userList = Import-Csv -Path "C:\temp\emailaddresscompany.csv"

foreach ($user in $userList) {
    Get-ADUser -Identity $user.samaccountname | Set-ADUser -Company $($user.company)
}

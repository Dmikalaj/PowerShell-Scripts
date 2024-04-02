#Script to bulk update active directory attributes using csv file# 

####Prerequisites####
Import-Module ActiveDirectory
###
# Import the CSV file
$userList = Import-Csv -Path "C:\temp\emailaddresscompany.csv"

foreach ($user in $userList) {
    Get-ADUser -Identity $user.samaccountname | Set-ADUser -Company $($user.company) 
    Get-ADuser -Identity $user.samaccountname | Set-ADUser -Replace @{info='Update20231011'}
    Get-ADuser -Identity $user.samaccountname | Set-ADUser -Manager $($user.manager)
    Get-ADuser -Identity $user.samaccountname | Set-ADUser -Department $($user.department)
    Get-ADuser -Identity $user.samaccountname | Set-ADUser -Title $($user.title)
    Get-ADuser -Identity $user.samaccountname | Set-ADUser -Description $($user.description)
}
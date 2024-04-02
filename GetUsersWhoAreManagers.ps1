#Script to query AD and return a list of users who have direct reports/export to csv# 
Import-Module activedirectory
###

# Get a list of users who have direct reports
$managerUsers = Get-ADUser -Filter {directreports -like '*' } 

# Display the list of users, export to a csv file
$managerUsers | Select-Object Name,username | export-csv c:\temp\ListOfManagers1.csv -NoTypeInformation
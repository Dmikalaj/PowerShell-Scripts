#Script to import a csv with usernames and return a list of their direct reports/ export to csv# 
Import-Module ActiveDirectory
# Path of csv with the names of the managers
$CSVPath = 'C:\temp\managernames.csv'
# Output file
$ExportCSV = 'C:\temp\output1.csv'
$Properties = @(
    'DirectReports'
)

# Import the CSV file containing user data
$UserList = Import-Csv -Path $CSVPath

# Create an array to store the user data
$UserArray = @()

# Loop through each user in the CSV
foreach ($User in $UserList) {
    $TargetUser = $User.samaccountname

    $rep = Get-Aduser -Identity $TargetUser -Properties $Properties

    if (!$rep.DirectReports) {
        Write-Host "No Direct reports for user"
    } else {
        $UserObject = $rep | Select-Object Name, samaccountname, description, office, telephoneNumber, EmailAddress, @{
            n = "DirectReports"
            e = {$_.DirectReports -join ';'}
        }
        $UserArray += $UserObject
    }
}

# Export the entire list of users to a CSV
$UserArray | Export-Csv -Path $ExportCSV -NoTypeInformation

#Script to find deleted emails in a given time range/export to csv for review
###Prerequisites###
Connect-ExchangeOnline
###

$1 = Get-RecoverableItems -Identity "EMAIL@keystoneind.com" -SourceFolder "deleteditems" -FilterStartTime "12/6/2023 12:00:00 AM" -FilterEndTime "12/13/2023 11:59:59 PM"

$1 | Export-Csv -LiteralPath 'C:\Temp\sent1.csv' -NoTypeInformation
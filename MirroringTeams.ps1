# First email: Person being mirrored, Second email: User getting the teams 
# Run checks by using: get-team -user user@keystoneind.com
Connect-MicrosoftTeams

Get-Team -user 1@keystoneind.com | foreach {Add-TeamUser -GroupId $_.groupid -User 1@keystoneind.com -Role Member}
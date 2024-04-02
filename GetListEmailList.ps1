#####AUTH#####
$SecFile = "" #Location of encrypted password file
$SecUse = "@keystoneind.com" #Username
$MyCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $SecUse, (Get-Content $SecFile | ConvertTo-SecureString)

#Connect to Modules:
Connect-AzureAD -credential $MyCredential
Connect-ExchangeOnline -Credential $MyCredential

#################################################################################

# EXEMPTION LIST
$exemptionList = @("@keystoneind.com")

# Get all shared mailboxes
$sharedMailboxes = Get-Mailbox -RecipientTypeDetails SharedMailbox

# Store the mailboxes with enabled user accounts in an array
$sharedMailboxesWithUser = @()

# Go through each shared mailbox and check if the corresponding user is enabled
foreach ($mailbox in $sharedMailboxes) {
    $userPrincipalName = $mailbox.UserPrincipalName
    $user = Get-AzureADUser -Filter "UserPrincipalName eq '$userPrincipalName' and accountEnabled eq true"
# Check if the mailbox is not in the exemption list
    if ($user -and $exemptionList -notcontains $userPrincipalName) {
        $sharedMailboxesWithUser += $mailbox
    }
}

# Format into a table
$resultsTable = $sharedMailboxesWithUser | Select-Object DisplayName, UserPrincipalName | Format-Table -AutoSize | Out-String

# Send results via email
$subject = "Shared Mailboxes with Enabled User Accounts"
$body = "The following shared mailboxes have user accounts that are still enabled:`r`n`r`n$resultsTable"
$smtpServer = "smtp.office365.com"  
$smtpPort = 587                   
$smtpUsername = ""  
$smtpPassword = ""    
$senderEmail = ""
$recipientEmail = ""

Send-MailMessage -From $senderEmail -To $recipientEmail -Subject $subject -Body $body -SmtpServer $smtpServer -UseSsl -Port $smtpPort -Credential (New-Object System.Management.Automation.PSCredential ($smtpUsername, (ConvertTo-SecureString $smtpPassword -AsPlainText -Force)))

Write-Host `n~~ Script Completed ~~`n -ForegroundColor Green
#Script to filter through every user and all of their inbox rules to find a keyword.
#Edit line 10 to add a keyword
Connect-ExchangeOnline
###

$users = Get-Mailbox -ResultSize Unlimited
foreach ($user in $users) {
    $rules = Get-InboxRule -Mailbox $user.UserPrincipalName
    foreach ($rule in $rules) {
        if ($rule.Description -like "*RSS*") { 
            Write-Host "User: $($user.UserPrincipalName), Rule Name: $($rule.Name), Rule Description: $($rule.Description)"
        } 

    
    }
}
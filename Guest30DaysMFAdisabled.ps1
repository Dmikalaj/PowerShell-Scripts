#Script to get guest accounts older than 30 days that have MFA disabled
###Edit date on line 56 to 30 days ago###
$30daysold = (Get-Date).AddDays(-30)

Connect-MgGraph
Connect-AzureAD

{
 #Check for module installation
 $MsGraphBetaModule =  Get-Module Microsoft.Graph.Beta -ListAvailable
 if($MsGraphBetaModule -eq $null)
 { 
    Write-host "Important: Microsoft Graph Beta module is unavailable. It is mandatory to have this module installed in the system to run the script successfully." 
    $confirm = Read-Host Are you sure you want to install Microsoft Graph Beta module? [Y] Yes [N] No  
    if($confirm -match "[yY]") 
    { 
        Write-host "Installing Microsoft Graph Beta module..."
        Install-Module Microsoft.Graph.Beta -Scope CurrentUser -AllowClobber
        Write-host "Microsoft Graph Beta module is installed in the machine successfully" -ForegroundColor Magenta 
    } 
    else
    { 
        Write-host "Exiting. `nNote: Microsoft Graph Beta module must be available in your system to run the script" -ForegroundColor Red
        Exit 
    } 
 }
 #Disconnect Existing MgGraph session
 if($CreateSession.IsPresent)
 {
  Disconnect-MgGraph
 }
 #Connecting to MgGraph beta
 Write-Host Connecting to Microsoft Graph...
 Connect-MgGraph -Scopes "User.Read.All","UserAuthenticationMethod.Read.All"
}

Write-Host "`nNote: If you encounter module related conflicts, run the script in a fresh PowerShell window.`n" -ForegroundColor Yellow
if((Get-MgContext) -ne "")
{
 Write-Host Connected to Microsoft Graph PowerShell using (Get-MgContext).Account account -ForegroundColor Yellow
}
$ProcessedUserCount=0
$ExportCount=0
 #Set output file 
 $ExportCSV="c:\temp\MFAstatus.csv"
  $Result=""  
 $Results=@()

#Get all users
Get-AzureADUser -All $true | Where-Object { $_.AccountEnabled -eq $true -and $_.UserType -eq "Guest" -and $_.createdDateTime -lt $30daysold} | foreach {
 $ProcessedUserCount++
 $Name= $_.DisplayName
 $UPN=$_.UserPrincipalName
 $Department=$_.CreatedDateTime
 if($_.AccountEnabled -eq $true)
 {
  $SigninStatus="Allowed"
 }
 else
 {
  $SigninStatus="Blocked"
 }
 if(($_.AssignedLicenses).Count -ne 0)
 {
  $LicenseStatus="Licensed"
 }
 else
 {
  $LicenseStatus="Unlicensed"
 }   
 $Is3rdPartyAuthenticatorUsed="False"
 $MFAPhone="-"
 $MicrosoftAuthenticatorDevice="-"
 Write-Progress -Activity "`n     Processed users count: $ProcessedUserCount "`n"  Currently processing user: $Name"
 [array]$MFAData=Get-MgBetaUserAuthenticationMethod -UserId $UPN
 $AuthenticationMethod=@()
 $AdditionalDetails=@()
 
 foreach($MFA in $MFAData)
 { 
   Switch ($MFA.AdditionalProperties["@odata.type"]) 
   { 
    "#microsoft.graph.passwordAuthenticationMethod"
    {
     $AuthMethod     = 'PasswordAuthentication'
     $AuthMethodDetails = $MFA.AdditionalProperties["displayName"] 
    } 
    "#microsoft.graph.microsoftAuthenticatorAuthenticationMethod"  
    { # Microsoft Authenticator App
     $AuthMethod     = 'AuthenticatorApp'
     $AuthMethodDetails = $MFA.AdditionalProperties["displayName"] 
     $MicrosoftAuthenticatorDevice=$MFA.AdditionalProperties["displayName"]
    }
    "#microsoft.graph.phoneAuthenticationMethod"                  
    { # Phone authentication
     $AuthMethod     = 'PhoneAuthentication'
     $AuthMethodDetails = $MFA.AdditionalProperties["phoneType", "phoneNumber"] -join ' ' 
     $MFAPhone=$MFA.AdditionalProperties["phoneNumber"]
    } 
    "#microsoft.graph.fido2AuthenticationMethod"                   
    { # FIDO2 key
     $AuthMethod     = 'Fido2'
     $AuthMethodDetails = $MFA.AdditionalProperties["model"] 
    }  
    "#microsoft.graph.windowsHelloForBusinessAuthenticationMethod" 
    { # Windows Hello
     $AuthMethod     = 'WindowsHelloForBusiness'
     $AuthMethodDetails = $MFA.AdditionalProperties["displayName"] 
    }                        
    "#microsoft.graph.emailAuthenticationMethod"        
    { # Email Authentication
     $AuthMethod     = 'EmailAuthentication'
     $AuthMethodDetails = $MFA.AdditionalProperties["emailAddress"] 
    }               
    "microsoft.graph.temporaryAccessPassAuthenticationMethod"   
    { # Temporary Access pass
     $AuthMethod     = 'TemporaryAccessPass'
     $AuthMethodDetails = 'Access pass lifetime (minutes): ' + $MFA.AdditionalProperties["lifetimeInMinutes"] 
    }
    "#microsoft.graph.passwordlessMicrosoftAuthenticatorAuthenticationMethod" 
    { # Passwordless
     $AuthMethod     = 'PasswordlessMSAuthenticator'
     $AuthMethodDetails = $MFA.AdditionalProperties["displayName"] 
    }      
    "#microsoft.graph.softwareOathAuthenticationMethod"
    { 
      $AuthMethod     = 'SoftwareOath'
      $Is3rdPartyAuthenticatorUsed="True"            
    }
    
   }
   $AuthenticationMethod +=$AuthMethod
   if($AuthMethodDetails -ne $null)
   {
    $AdditionalDetails +="$AuthMethod : $AuthMethodDetails"
   }
  }
  #To remove duplicate authentication methods
  $AuthenticationMethod =$AuthenticationMethod | Sort-Object | Get-Unique
  $AuthenticationMethods= $AuthenticationMethod  -join ","
  $AdditionalDetail=$AdditionalDetails -join ", "
  $Print=1
  #Determine MFA status
  [array]$StrongMFAMethods=("Fido2","PhoneAuthentication","PasswordlessMSAuthenticator","AuthenticatorApp","WindowsHelloForBusiness")
  $MFAStatus="Disabled"
 

  foreach($StrongMFAMethod in $StrongMFAMethods)
  {
   if($AuthenticationMethod -contains $StrongMFAMethod)
   {
    $MFAStatus="Strong"
    break
   }
  }

  if(($MFAStatus -ne "Strong") -and ($AuthenticationMethod -contains "SoftwareOath"))
  {
   $MFAStatus="Weak"
  }
  #Filter result based on MFA status
  if($MFADisabled.IsPresent -and $MFAStatus -ne "Disabled")
  {
   $Print=0
  }
  if($MFAEnabled.IsPresent -and $MFAStatus -eq "Disabled")
  {
   $Print=0
  }

  #Filter result based on license status
  if($LicensedUsersOnly.IsPresent -and ($LicenseStatus -eq "Unlicensed"))
  {
   $Print=0
  }

  #Filter result based on signin status
  if($SignInAllowedUsersOnly.IsPresent -and ($SigninStatus -eq "Blocked"))
  {
   $Print=0
  }
 
 if($Print -eq 1)
 {
  $ExportCount++
  $Result=@{'Name'=$Name;'UPN'=$UPN;'Date Created'=$Department;'License Status'=$LicenseStatus;'SignIn Status'=$SigninStatus;'Authentication Methods'=$AuthenticationMethods;'MFA Status'=$MFAStatus;'MFA Phone'=$MFAPhone;'Microsoft Authenticator Configured Device'=$MicrosoftAuthenticatorDevice;'Is 3rd-Party Authenticator Used'=$Is3rdPartyAuthenticatorUsed;'Additional Details'=$AdditionalDetail} 
  $Results= New-Object PSObject -Property $Result 
  $Results | Select-Object Name,'UPN','License Status','SignIn Status','Authentication Methods','MFA Status','MFA Phone','Is 3rd-Party Authenticator Used','Date Created' | Export-Csv -Path $ExportCSV -Notype -Append
 }
}

 Write-Host `n~~ Script Completed ~~`n -ForegroundColor Green
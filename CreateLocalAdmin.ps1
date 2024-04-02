#Script to create local admin#
#Useful alternative to LAPS, run remotely using RMM, Remote into machine, log in with new credentials as local admin..

New-LocalUser -AccountNeverExpires:$true -Password ( ConvertTo-SecureString -AsPlainText -Force 'PASSWORD') -Name 'USERNAME' | Add-LocalGroupMember -Group administrators


#join existing account to local admin group on the machine:
#Add-LocalGroupMember -Group "Administrators" -Member "KEYSTONE\ksiadmin-rw"
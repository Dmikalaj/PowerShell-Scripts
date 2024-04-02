#Script to create a txt file to reference in other scripts to avoid passwords being written as cleartext in script#

#Run as the user that will be executing the script 

(Get-Credential).Password | ConvertFrom-SecureString | Out-File "C:\temp\ENC.txt"
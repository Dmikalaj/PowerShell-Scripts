#Script to clear outlook cache

$VerbosePreference = continue 

Stop-Process -Name OUTLOOK
Stop-Process -Name olk

Start-Sleep -Seconds 5

Remove-Item "C:\Users\$env:UserName\AppData\Local\Microsoft\Windows\INetCache\Content.Outlook\*" -Recurse -verbose -Force
Remove-Item "C:\Users\$env:UserName\AppData\Local\Microsoft\Outlook\RoamCache" -Recurse -verbose -Force
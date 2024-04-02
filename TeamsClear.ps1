#Script to close and clear teams cache
$VerbosePreference = 'continue'
Stop-Process -Name Teams -Force
Stop-Process -Name OUTLOOK -Force

Set-Location ~

Remove-Item -Path '.\AppData\Roaming\Microsoft\Teams' -Force -Verbose -Recurse
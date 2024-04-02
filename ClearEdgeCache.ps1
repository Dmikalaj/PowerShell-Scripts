#Script to clear Microsoft Edge cache# 



# Define the path to the Edge cache for a specific user

$edgeCachePath = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache"

# Define the path to the Edge cookies for a specific user

$edgeCookiesPath = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cookies"

# Kill any running Edge tasks

Stop-Process -Name msedge -Force -ErrorAction SilentlyContinue

# Clear the Edge cache

Remove-Item -Path "$edgeCachePath\*" -Recurse -Force -ErrorAction SilentlyContinue

# Clear the Edge cookies

Remove-Item -Path $edgeCookiesPath -Force -ErrorAction SilentlyContinue
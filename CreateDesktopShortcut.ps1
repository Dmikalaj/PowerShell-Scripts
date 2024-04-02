#Script to create a shortcut to url on windows desktop# 


$new_object = New-Object -ComObject WScript.Shell
$destination = $new_object.SpecialFolders.Item('AllUsersDesktop')
$source_path = Join-Path -Path $destination -ChildPath '\\Salesforce.lnk'
$source = $new_object.CreateShortcut($source_path)
$source.TargetPath = 'https://login.salesforce.com'
$source.Save()
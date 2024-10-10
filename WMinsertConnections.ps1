#Script used for desktop version Warehouse Management - Used for remote uploading of the connections.JSON

# Host the connections.JSON in a reachable file path, add full path to variable
$sourceFilePath = "\\SERVER\FOLDER\CONNECTIONS.JSON"

$destinationFolderPath = "C:\Users\$env:UserName\AppData\Local\Packages\Microsoft.WarehouseManagement_8wekyb3d8bbwe\LocalState"

$fileName = [System.IO.Path]::GetFileName($sourceFilePath)

$destinationFilePath = Join-Path -Path $destinationFolderPath -ChildPath $fileName

Copy-Item -Path $sourceFilePath -Destination $destinationFilePath -Force

<#
CONNECTIONS.JSON format:
{
    "ConnectionList": [
        {
            "ActiveDirectoryClientAppId":"",
            "ConnectionName": "",
            "ActiveDirectoryResource": "",
            "ActiveDirectoryTenant": "",
            "Company": "",
            "IsEditable": false,
            "IsDefaultConnection": true,
            "UseBroker": false,
            "ConnectionType": "UsernamePassword",
            "AuthCloud": "Manual"
        },
	{
            "ActiveDirectoryClientAppId":"",
            "ConnectionName": "",
            "ActiveDirectoryResource": "",
            "ActiveDirectoryTenant": "",
            "Company": "",
            "IsEditable": false,
            "IsDefaultConnection": false,
            "UseBroker": false,
            "ConnectionType": "UsernamePassword",
            "AuthCloud": "Manual"
        }

    ]
}
#>

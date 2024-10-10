# Specify the root directory from which to start recursing
$rootDirectory = "C:\Windows\ccmcache"

# Array of file names to delete
$fileNamesToDelete = @("connections.json", "install.ps1")

# Recursively get files matching the specified names and delete them
foreach ($fileName in $fileNamesToDelete) {
    $filesToDelete = Get-ChildItem -Path $rootDirectory -Filter $fileName -File -Recurse
    if ($filesToDelete) {
        foreach ($file in $filesToDelete) {
            try {
                Remove-Item -Path $file.FullName -Force -ErrorAction Stop
                Write-Host "File removed successfully: $($file.FullName)"
            } catch {
                Write-Host "Failed to remove file: $($file.FullName)"
                Write-Host $_.Exception.Message
            }
        }
    } else {
        Write-Host "No files found matching pattern: $fileName in directory: $rootDirectory"
    }
}

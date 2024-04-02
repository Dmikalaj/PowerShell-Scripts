#Cleanup SCCM content library on the distribution point. Run command on the local machine 

Set-Location 'D:\Program Files\Microsoft Configuration Manager\cd.latest\SMSSETUP\TOOLS\ContentLibraryCleanup'

.\contentlibrarycleanup.exe /dp kgsvsysman02.keystoneind.com /log c:\temp
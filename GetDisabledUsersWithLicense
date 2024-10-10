#Run Get-MsolAccountSku for list of licenses, Replace "POWER_BI_PRO" with desired license

Get-MsolUser -All | Where-Object {($_.licenses).AccountSkuId -match "POWER_BI_PRO"-and $_.BlockCredential -eq $true} 

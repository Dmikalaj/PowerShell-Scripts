#Script to force AzureAD sync to push through changes made in active directory to azure

invoke-Command -ComputerName kgsvazure01 -ScriptBlock {Start-AdSyncSyncCycle -PolicyType Delta}
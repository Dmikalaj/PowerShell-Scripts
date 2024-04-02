#Script to create and assign a public IP address to a virtual machine created from a failover# 

####Prerequisites####
# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process

# Connect to Azure with system-assigned managed identity
$AzureContext = (Connect-AzAccount -Identity).context

# Set and store context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext  

Install-Module -Name Az.Accounts -Force
Install-Module -Name Az.network -Force
#####################

#CreatePIP
New-AzPublicIpAddress -Name 'pip-KGSVFPS01-test' -ResourceGroupName AzureStackHCIRecoveryRG -Location westus -Sku Basic -AllocationMethod Static -IpAddressVersion IPv4
New-AzPublicIpAddress -Name 'pip-AXApps-test' -ResourceGroupName AzureStackHCIRecoveryRG -Location westus -Sku Basic -AllocationMethod Static -IpAddressVersion IPv4
New-AzPublicIpAddress -Name 'pip-AXSQLPRD-test' -ResourceGroupName AzureStackHCIRecoveryRG -Location westus -Sku Basic -AllocationMethod Static -IpAddressVersion IPv4

#Allow time for the PIP to create prior to setting variables/updating NIC
Start-Sleep -Seconds 15

#Virtual Network
$vnet = Get-AzVirtualNetwork -Name RecoveryNetworkTestVNET -ResourceGroupName AzureStackHCIRecoveryRG
$subnet = Get-AzVirtualNetworkSubnetConfig -Name RecoveryNetworkSUBNET011 -VirtualNetwork $vnet
#0 KGSVFPS01
$nic = Get-AzNetworkInterface -Name nic-KGSVFPS01-00-test -ResourceGroupName AzureStackHCIRecoveryRG
$pip = Get-AzPublicIpAddress -Name pip-KGSVFPS01-test -ResourceGroupName AzureStackHCIRecoveryRG
#1 AXAPPS
$nic1 = Get-AzNetworkInterface -Name nic-AXApps-00-test -ResourceGroupName AzureStackHCIRecoveryRG
$pip1 = Get-AzPublicIpAddress -Name pip-AXApps-test -ResourceGroupName AzureStackHCIRecoveryRG
#2 AXSQLPRD
$nic2 = Get-AzNetworkInterface -Name nic-AXSQLPRD-00-test -ResourceGroupName AzureStackHCIRecoveryRG
$pip2 = Get-AzPublicIpAddress -Name pip-AXSQLPRD-test -ResourceGroupName AzureStackHCIRecoveryRG

#Update NIC
$nic | Set-AzNetworkInterfaceIpConfig -Name nic-KGSVFPS01-00-test-ipConfig -PublicIPAddress $pip -Subnet $subnet
$nic | Set-AzNetworkInterface

$nic1 | Set-AzNetworkInterfaceIpConfig -Name nic-AXApps-00-test-ipConfig -PublicIPAddress $pip1 -Subnet $subnet
$nic1 | Set-AzNetworkInterface

$nic2 | Set-AzNetworkInterfaceIpConfig -Name nic-AXSQLPRD-00-test-ipConfig -PublicIPAddress $pip2 -Subnet $subnet
$nic2 | Set-AzNetworkInterface
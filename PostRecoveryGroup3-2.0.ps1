###                                                                                              ###
#Script to create and assign a public IP address to a virtual machine created during a failover# 
###                                                                                              ###

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

#Virtual Network
$vnet = Get-AzVirtualNetwork -Name RecoveryNetworkTestVNET -ResourceGroupName AzureStackHCIRecoveryRG
$subnet = Get-AzVirtualNetworkSubnetConfig -Name RecoveryNetworkSUBNET011 -VirtualNetwork $vnet

#6 KGSVEMS01
$nic6 = Get-AzNetworkInterface -Name nic-KGSVEMS01-00-test -ResourceGroupName AzureStackHCIRecoveryRG
$pip6 = Get-AzPublicIpAddress -Name RecoveryNetworkEMSPIP -ResourceGroupName RecoveryNetworkRG

$nic6 | Set-AzNetworkInterfaceIpConfig -Name nic-KGSVEMS01-00-test-ipConfig -PublicIPAddress $pip6 -Subnet $subnet
$nic6 | Set-AzNetworkInterface
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

#1 KGSVRDSBROKER01
$nic1 = Get-AzNetworkInterface -Name nic-KGSVRDSBROKER01-00-test -ResourceGroupName AzureStackHCIRecoveryRG
$pip1 = Get-AzPublicIpAddress -Name RecoveryNetworkRDWebPIP -ResourceGroupName RecoveryNetworkRG
#2 KGSVAZURE01
$nic2 = Get-AzNetworkInterface -Name nic-KGSVAZURE01-00-test -ResourceGroupName AzureStackHCIRecoveryRG
$pip2 = Get-AzPublicIpAddress -Name RecoveryNetworkO365PIP -ResourceGroupName RecoveryNetworkRG


#Update NIC

$nic1 | Set-AzNetworkInterfaceIpConfig -Name nic-KGSVRDSBROKER01-00-test-ipConfig -PublicIPAddress $pip1 -Subnet $subnet
$nic1 | Set-AzNetworkInterface

$nic2 | Set-AzNetworkInterfaceIpConfig -Name nic-KGSVAZURE01-00-test-ipConfig -PublicIPAddress $pip2 -Subnet $subnet
$nic2 | Set-AzNetworkInterface
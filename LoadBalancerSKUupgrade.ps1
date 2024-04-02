<# 
Upgrade will cause downtime

How long does the Upgrade take?
The upgrade normally takes a few minutes for the script to finish. The following factors may lead to longer upgrade times:

Complexity of your load balancer configuration
Number of backend pool members
Instance count of associated Virtual Machine Scale Sets or Virtual Machines
Service Fabric Cluster: Upgrades for Service Fabric Clusters take around an hour in testing
Keep the downtime in mind and plan for failover if necessary.
#>

Install-Module -Name AzureBasicLoadBalancerUpgrade -Scope CurrentUser -Repository PSGallery -Force

Connect-AzAccount -Tenant <TenantId> -Subscription <SubscriptionId>

# Upgrade Load Balancers to Standard

# VALIDATE: Start-AzBasicLoadBalancerUpgrade -ResourceGroupName <loadBalancerRGName> -BasicLoadBalancerName <basicLBName> -validateScenarioOnly

Start-AzBasicLoadBalancerUpgrade -ResourceGroupName <loadBalancerRGName> -BasicLoadBalancerName <basicLBName>


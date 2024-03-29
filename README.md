# Azure Terraform Modules Repository

![Azure Logo](https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Microsoft_Azure_Logo.svg/1280px-Microsoft_Azure_Logo.svg.png)

This repository contains a collection of Terraform modules for provisioning resources on Microsoft Azure. These modules are designed to simplify the deployment and management of Azure resources using Terraform.

## Table of Contents

### Prerequisites

Before using these Terraform modules, make sure you have the following prerequisites installed on your machine:

- [Terraform](https://www.terraform.io/downloads.html)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

## Directory Hierarchy

The repository follows the following directory hierarchy structure:

## Modules

- **Compute**:
    - [linux-virtual-machine](modules/Compute/linux-virtual-machine): Module for creating Linux virtual machines.
    - [linux-vmss](modules/Compute/linux-vmss): Module for creating Linux Virtual Machine Scale Sets. 
    - [windows-virtual-machine](modules/Compute/windows-virtual-machine): Module for creating Windows virtual machines.
    - [windows-vmss](modules/Compute/windows-vmss): Module for creating Windows Virtual Machine Scale Sets.

- **Containers**:
    - [aks](modules/Containers/aks): Module for creating AKS clusters.
    - [container-registry](modules/Containers/container-registry): Module for creating container registries.
    - [container-apps](modules/Containers/container-apps): Module for creating container apps.

- **Databases**:
    - [cosmosdb](modules/Databases/cosmosdb): Module for creating Cosmos DB accounts.
    - [cosmosdb-postgresql-cluster](modules/Databases/cosmosdb_postgresql_cluster): Module for creating Cosmos DB PostgreSQl Cluster.
    - [mssql](modules/Databases/mssql): Module for creating SQL Server instances and databases.
    - [mysql](modules/Databases/mysql): Module for creating MySQL databases and Flexible Server.
    - [postgres-single](modules/Databases/postgres-single): Module for creating PostgreSQL databases and Single Server.
    - [postgres-flexi](modules/Databases/postgres-flexi): Module for creating PostgreSQL databases and Flexible Server.

- **Management**:
    - [autoscale](modules/Management/autoscale): Module for creating autoscale rules.
    - [identity](modules/Management/identity): Module for creating User Assigned Identity.
    - [resource-group](modules/Management/resource-group): Module for creating resource groups.
    - [management-lock](modules/Management/management-lock): Module for creating management-lock for azure.
  
- **Monitoring**:
    - [application-insights](modules/Moniter/application-insights): Module for creating application insights.
    - [log-analytics-workspace](modules/Moniter/log-analytics-workspace): Module for creating log analytics workspaces.
    - [diagnostic-settings](modules/Moniter/diagnostic-setting): Module for creating diagnostic settings.

- **Networking**:
    - [application-gateway](modules/Networking/application-gateway): Module for creating application gateways.
    - [cdn-frontdoor](modules/Networking/cdn-frontdoor): Module for creating cdn-frontdoor.
    - [frontdoor-classic](modules/Networking/frontdoor-classic): Module for creating frontdoor-classic.
    - [firewall](modules/Networking/firewall-tools/firewall): Module for creating firewalls.
    - [firewall-policy](modules/Networking/firewall-tools/policy): Module for creating firewall policies.
    - [firewall-rule-collection-group](modules/Networking/firewall-tools/rule-collection-group): Module for creating firewall rule collection groups.
    - [load-balancer](modules/Networking/load-balancer): Module for creating load balancers.
    - [nat-gateway](modules/Networking/nat-gateway): Module for creating NAT gateways.
    - [network-interface](modules/Networking/network-interface): Module for creating network interfaces.
    - [network-security-group](modules/Networking/network-security-group): Module for creating network security groups.
    - [private-dns-zone](modules/Networking/private-dns-zone): Module for creating private DNS zones.
    - [public-ip](modules/Networking/public-ip): Module for creating public IPs.
    - [private-endpoint](modules/Networking/private-endpoint): Module for creating private-endpoint.
    - [route-table](modules/Networking/route-table): Module for creating route tables.
    - [service-bus](modules/Networking/service-bus): Module for creating service-bus.
    - [virtual-network](modules/Networking/virtual-network): Module for creating virtual networks.
    - [vnet-peering](modules/Networking/vnet-peering): Module for creating VNet peering.

- **Security**:
    - [key-vault](modules/Security/key-vault): Module for creating key vaults.

- **Storage**:
    - [storage-account](modules/Storage/storage-account): Module for creating storage accounts.
    - [redis-cache](modules/Storage/redis-cache): Module for creating redis-cache.
  
- **Web**:
    - [api-management](modules/Web/api-management): Module for creating API management services.
    - [linux-web-apps](modules/Web/linux-web-apps): Module for creating Linux web apps.
    - [linux-function-app](modules/Web/linux-function-app): Module for creating Linux function apps.
    - [window-function-app](modules/Web/window-function-app): Module for creating Window function apps.
    - [service-plan](modules/Web/service-plan): Module for creating service plans.
    - [static-web-apps](modules/Web/static-web-apps): Module for creating static web apps.

Please refer to the respective module's directory for more details.
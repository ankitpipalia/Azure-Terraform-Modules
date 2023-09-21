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

- Compute: Contains configurations for creating compute resources.
  - [linux-virtual-machine](modules/Compute/linux-virtual-machine): Module for creating Linux virtual machines.
  - [linux-vmss](modules/linux-vmss): Module for creating Linux Virtual Machine Scale Sets.
  - [windows-virtual-machine](modules/Compute/windows-virtual-machine): Module for creating Windows virtual machines.
  - [windows-vmss](modules/Compute/windows-vmss): Module for creating Windows Virtual Machine Scale Sets.

- **Databases**: Contains configurations for creating database resources.
  - [`mssql-database`](<link_to_mssql_database>): Module for creating SQL Server databases.
  - [`mssql-server`](<link_to_mssql_server>): Module for creating SQL Server instances.

- **Management**: Contains configurations for creating management resources.
  - [`autoscale`](<link_to_autoscale>): Module for creating autoscale rules.
  - [`resource-group`](<link_to_resource_group>): Module for creating resource groups.

- **Networking**: Contains configurations for creating networking resources.
  - [`load-balancer`](<link_to_load_balancer>): Module for creating load balancers.
  - [`nat-gateway`](<link_to_nat_gateway>): Module for creating NAT gateways.
  - [`network-interface`](<link_to_network_interface>): Module for creating network interfaces.
  - [`network-security-group`](<link_to_network_security_group>): Module for creating network security groups.
  - [`private-dns-zone`](<link_to_private_dns_zone>): Module for creating private DNS zones.
  - [`public-ip`](<link_to_public_ip>): Module for creating public IPs.
  - [`route-table`](<link_to_route_table>): Module for creating route tables.
  - [`subnets`](<link_to_subnets>): Module for creating subnets.
  - [`virtual-network`](<link_to_virtual_network>): Module for creating virtual networks.
  - [`vnet-peering`](<link_to_vnet_peering>): Module for creating VNet peering.

- **Storage**: Contains configurations for creating storage resources.
  - [`storage-account`](<link_to_storage_account>): Module for creating storage accounts.

- **Web**: Contains configurations for creating web resources.
  - [`linux-web-apps`](<link_to_linux_web_apps>): Module for creating Linux web apps.
  - [`service-plan`](<link_to_service_plan>): Module for creating service plans.
  - [`static-web-apps`](<link_to_static_web_apps>): Module for creating static web apps.

Please refer to the respective module's directory for more details.
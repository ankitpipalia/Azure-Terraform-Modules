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

- **Compute**: Contains configurations for creating compute resources.
  - `linux-virtual-machine`: Module for creating Linux virtual machines.
  - `linux-vmss`: Module for creating Linux Virtual Machine Scale Sets.
  - `windows-virtual-machine`: Module for creating Windows virtual machines.

- **Databases**: Contains configurations for creating database resources.
  - `mssql-database`: Module for creating SQL Server databases.
  - `mssql-server`: Module for creating SQL Server instances.

- **Management**: Contains configurations for creating management resources.
  - `autoscale`: Module for creating autoscale rules.
  - `resource-group`: Module for creating resource groups.

- **Networking**: Contains configurations for creating networking resources.
  - `load-balancer`: Module for creating load balancers.
  - `nat-gateway`: Module for creating NAT gateways.
  - `network-interface`: Module for creating network interfaces.
  - `network-security-group`: Module for creating network security groups.
  - `private-dns-zone`: Module for creating private DNS zones.
  - `public-ip`: Module for creating public IPs.
  - `route-table`: Module for creating route tables.
  - `subnets`: Module for creating subnets.
  - `virtual-network`: Module for creating virtual networks.
  - `vnet-peering`: Module for creating VNet peering.

- **Storage**: Contains configurations for creating storage resources.
  - `storage-account`: Module for creating storage accounts.

- **Web**: Contains configurations for creating web resources.
  - `linux-web-apps`: Module for creating Linux web apps.
  - `service-plan`: Module for creating service plans.
  - `static-web-apps`: Module for creating static web apps.

Please refer to the respective module's directory for more details.
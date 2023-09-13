# Azure Virtual Network Terraform Module

This Terraform module creates a simple Azure virtual network.

## Prerequisites

- Terraform installed on your local machine
- Azure subscription

## Usage

```hcl
module "virtual_network" {
  source                  = "path/to/module"
  virtual_network_name    = "my-vnet"
  address_space           = ["10.0.0.0/16"]
  location                = "eastus"
  resource_group_name     = "my-resource-group"
  tags                    = {
    environment = "dev"
    project     = "my-project"
  }
}
```

## Inputs

| Name                   | Description                           | Type         | Default | Required |
|------------------------|---------------------------------------|--------------|---------|----------|
| virtual_network_name   | The name of the virtual network       | string       |         | yes      |
| address_space          | The address space of the virtual network | list(string) |         | yes      |
| location               | The location of the virtual network   | string       |         | yes      |
| resource_group_name    | The name of the resource group         | string       |         | yes      |
| tags                   | The tags to associate with the virtual network | map(string) |         | yes      |

## Outputs

| Name                   | Description                           |
|------------------------|---------------------------------------|
| virtual_network_id     | The ID of the virtual network          |

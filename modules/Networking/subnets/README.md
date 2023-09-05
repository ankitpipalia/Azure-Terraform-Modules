# Azure Subnet Terraform Module

This Terraform module creates a simple Azure subnet.

## Prerequisites

- Terraform >= 0.12
- Azure CLI

## Usage

```hcl
module "subnet" {
  source                = "path/to/module"
  subnet_name           = var.subnet_name
  resource_group_name   = var.resource_group_name
  virtual_network_name  = var.virtual_network_name
  subnet_address_prefix = var.subnet_address_prefix
}
```

## Inputs

| Name                  | Description                       | Type   | Default | Required |
|-----------------------|-----------------------------------|--------|---------|----------|
| subnet_name           | The name of the subnet            | string | n/a     | yes      |
| resource_group_name   | The name of the resource group    | string | n/a     | yes      |
| virtual_network_name  | The name of the virtual network   | string | n/a     | yes      |
| subnet_address_prefix | The address prefix for the subnet | string | n/a     | yes      |

## Outputs

| Name       | Description          |
|------------|----------------------|
| subnet_id  | The ID of the subnet |

## Example

```hcl
module "subnet" {
  source                = "path/to/module"
  subnet_name           = "example-subnet"
  resource_group_name   = "example-resource-group"
  virtual_network_name  = "example-virtual-network"
  subnet_address_prefix = "10.0.0.0/24"
}

output "subnet_id" {
  value = module.subnet.subnet_id
}
```

# Terraform Module: Azure Network Security Group

This Terraform module creates an Azure Network Security Group (NSG) with predefined security rules.

## Usage

```hcl
module "network_security_group" {
  source                  = "path/to/module"
  network_security_group_name = "example-nsg"
  location                = "eastus"
  resource_group_name     = "example-resource-group"
}
```

## Inputs

| Name                          | Description                           | Type   | Default | Required |
|-------------------------------|---------------------------------------|--------|---------|----------|
| network_security_group_name   | Name of the network security group     | string |         | yes      |
| location                      | Location of the network security group | string |         | yes      |
| resource_group_name           | Name of the resource group             | string |         | yes      |

## Outputs

| Name                          | Description                           |
|-------------------------------|---------------------------------------|
| network_security_group_id     | ID of the created network security group |

## Security Rules

The module creates the following security rules:

1. **AllowSSH**: Allows inbound TCP traffic on port 22 from any source.
2. **AllowHTTP**: Allows inbound TCP traffic on port 80 from any source.
3. **AllowHTTPS**: Allows inbound TCP traffic on port 443 from any source.


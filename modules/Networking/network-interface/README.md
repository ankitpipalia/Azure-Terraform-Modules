# Terraform Module: Azure Network Interface

This Terraform module creates an Azure network interface.

## Usage

```hcl
module "network_interface" {
  source              = "path/to/module"
  network_interface_name            = var.network_interface_name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration_name = var.ip_configuration_name
  subnet_id = var.subnet_id
  private_ip_address_allocation = var.private_ip_address_allocation
  private_ip_address = var.private_ip_address
  public_ip_address_id = var.public_ip_address_id
  tags = var.tags
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| network_interface_name | The name of the network interface | string | n/a | yes |
| location | The location of the network interface | string | n/a | yes |
| resource_group_name | The name of the resource group | string | n/a | yes |
| ip_configuration_name | The name of the IP configuration | string | n/a | yes |
| subnet_id | The ID of the subnet | string | n/a | yes |
| private_ip_address_allocation | The allocation method for the private IP address | string | n/a | yes |
| private_ip_address | The private IP address | string | n/a | yes |
| public_ip_address_id | The ID of the public IP address | string | n/a | yes |
| tags | The tags for the network interface | map(string) | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| network_interface_id | The ID of the network interface |
| network_interface_private_ip | The private IP address of the network interface |
| network_interface_public_ip | The public IP address of the network interface |

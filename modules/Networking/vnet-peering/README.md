# Azure virtual network peering Terraform module
Terraform module for peering establishment between two virtual networks

## Usage
This module is provisioning peering between two virtual networks. Below is an example that provisions two virtual networks and peering between them.
```hcl
module "vpc_src" {
  source  = "data-platform-hq/network/azurerm"

  project        = "my_project"
  env            = "test"
  location       = "westeurope"
  resource_group = "test_group"
  cidr           = ["10.0.3.0/24"]
}

module "vpc_dst" {
  source  = "data-platform-hq/network/azurerm"

  project        = "my_project"
  env            = "dev"
  location       = "westeurope"
  resource_group = "dev_group"
  cidr           = ["172.16.0.0/16"]
}

module "peering" {
  source  = "data-platform-hq/peering/azurerm"

  src_peering_name             = module.vpc_dst.name
  src_resource_group_name      = "test_group"
  src_virtual_network_name     = module.vpc_scr.name
  src_virtual_network_id       = module.vpc_scr.id

  dst_peering_name             = module.vpc_scr.name
  dst_resource_group_name      = "dev_group"
  dst_virtual_network_name     = module.vpc_dst.name
  dst_virtual_network_id       = module.vpc_dst.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements
| Name                                                                      | Version   |
|---------------------------------------------------------------------------|-----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)       | >= 3.23.0 |

## Providers

| Name                                                           | Version   |
|----------------------------------------------------------------|-----------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm)  | >= 3.23.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                                            | Type     |
|-------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [azurerm_virtual_network_peering.src](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering)  | resource |
| [azurerm_virtual_network_peering.dst](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering)  | resource |


## Inputs

| Name                                                                                                                         | Description                                                                                         | Type     | Default  | Required |
|------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------|----------|----------|:--------:|
| <a name="input_src_peering_name"></a> [src\_peering\_name](#input\_src\_peering\_name)                                       | The name of the virtual network peering in source VPC                                               | `string` | n/a      |   yes    |
| <a name="input_src_resource_group_name"></a> [src\_resource\_group\_name](#input\_src\_resource\_group\_name)                | The name of the resource group in which to create the virtual network peering                       | `string` | n/a      |   yes    |
| <a name="input_src_virtual_network_name"></a> [src\_virtual\_network\_name](#input\_src\_virtual\_network\_name)             | The name of the source virtual network                                                              | `string` | n/a      |   yes    |
| <a name="input_src_virtual_network_id"></a> [src\_virtual\_network\_id](#input\_src\_virtual\_network\_id)                   | The full Azure resource ID of the source virtual network                                            | `string` | n/a      |   yes    |
| <a name="input_dst_peering_name"></a> [dst\_peering\_name](#input\_dst\_peering\_name)                                       | The name of the virtual network peering in destination VPC                                          | `string` | n/a      |   yes    |
| <a name="input_dst_resource_group_name"></a> [dst\_resource\_group\_name](#input\_dst\_resource\_group\_name)                | The name of the resource group in which to create the virtual network peering                       | `string` | n/a      |   yes    |
| <a name="input_dst_virtual_network_name"></a> [dst\_virtual\_network\_name](#input\_dst\_virtual\_network\_name)             | The name of the destination virtual network                                                         | `string` | n/a      |   yes    |
| <a name="input_dst_virtual_network_id"></a> [dst\_virtual\_network\_id](#input\_dst\_virtual\_network\_id)                   | The full Azure resource ID of the destination virtual network                                       | `string` | n/a      |   yes    |
| <a name="input_allow_virtual_network_access"></a> [allow\_virtual\_network\_access](#input\_allow\_virtual\_network\_access) | Controls if the VMs in the remote virtual network can access VMs in the local virtual network       | `bool`   | true     |    no    |
| <a name="input_allow_forwarded_traffic"></a> [allow\_forwarded\_traffic](#input\_allow\_forwarded\_traffic)                  | Controls if forwarded traffic from VMs in the remote virtual network is allowed                     | `bool`   | false    |    no    |
| <a name="input_allow_gateway_transit"></a> [allow\_gateway\_transit](#input\_allow\_gateway\_transit)                        | Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network | `bool`   | false    |    no    |
| <a name="input_use_remote_gateways"></a> [use\_remote\_gateways](#input\_use\_remote\_gateways)                              | Controls if remote gateways can be used on the local virtual network                                | `bool`   | false    |    no    |

## Outputs

| Name                                                                                                                  | Description                                |
|-----------------------------------------------------------------------------------------------------------------------|--------------------------------------------|
| <a name="src_peering_name_to_id_map"></a> [src\_peering\_name\_to\_id\_map](#output\_src\_peering\_name\_to\_id\_map) | Map of source peering name to its ID.      |
| <a name="dst_peering_name_to_id_map"></a> [dst\_peering\_name\_to\_id\_map](#output\_dst\_peering\_name\_to\_id\_map) | Map of destination peering name to its ID. |
<!-- END_TF_DOCS -->
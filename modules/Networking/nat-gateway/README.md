# Azure Nat Gateway Terraform module
Terraform module for creation Azure Nat Gateway

## Usage
This module is provisioning Public IP Address, Azure NAT Gateway which is associated with target subnets. 

```hcl
module "nat_gateway" {
  source = "./modules/Networking/nat-gateway"

  nat_gateway_name     = "test-nat-gateway"
  resource_group_name  = module.resource_group.name
  location             = module.resource_group.location
  public_ip_address_id = module.public_ip_address.id
  subnet_id            = module.subnets["subnet1"].id
  tags                 = local.tags
  extra_tags           = local.extra_tags
}

```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                         | Version   |
| ---------------------------------------------------------------------------- | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform)    | >= 1.0.0  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)          | >= 3.69.0 |

## Resources

| Name                                                                                                                | Type      |
|---------------------------------------------------------------------------------------------------------------------|-----------|
| [azurerm_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway)                                                                                        | resource  |
| [azurerm_nat_gateway_public_ip_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association)                                                                  | resource  |
| [azurerm_subnet_nat_gateway_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association)                                                                     | resource  |


## Inputs

## Inputs

| Name                   | Description                                      | Type     | Default | Required |
|------------------------|--------------------------------------------------|----------|---------|:--------:|
| `location`             | Azure location where the NAT Gateway is created. | string   | -       | yes      |
| `resource_group_name`  | Name of the Azure Resource Group.                | string   | -       | yes      |
| `nat_gateway_name`     | Name of the NAT Gateway.                         | string   | -       | yes      |
| `nat_sku`              | SKU (Service Level) of the NAT Gateway.         | string   | "Standard" | no      |
| `nat_idle_time`        | Idle timeout (in seconds) of the NAT Gateway.    | number   | 10      | no      |
| `nat_zones`            | List of availability zones for the NAT Gateway.  | list(string) | []    | no      |
| `public_ip_address_id` | ID of the associated public IP address.         | string   | -       | yes      |
| `subnet_id`            | ID of the subnet where the NAT Gateway is deployed. | string | -     | yes      |
| `tags`                 | Tags to be applied to resources (inclusive).     | object   | -       | yes      |
|                        | - `environment`: Environment tag.                | string   | -       | yes      |
|                        | - `project`: Project tag.                        | string   | -       | yes      |
| `extra_tags`           | Extra tags to be applied to resources in addition to the tags above. | map(string) | {} | no |

## Outputs

| Name                                                                                                                          | Description                                          |
| ----------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| <a name="output_nat_id"></a> [nat\_id](#output\_nat\_id)                     | Nat gateway id               |
<!-- END_TF_DOCS -->
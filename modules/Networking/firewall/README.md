# Azurerm_firewall

Deploy an Azure Firewall with a dedicated Terraform module.

<!-- BEGIN_TF_DOCS -->
## Usage

# Application Gateway Creation example

```hcl
module "firewall" {
  source = "./modules/Networking/firewall"

  firewall_name       = "test-fw"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  sku_name = "AZFW_VNet"
  sku_tier = "Standard"

  use_management_ip_configuration = true

  ip_configuration = [
    {
      name                 = "test-ip-config"
      subnet_id            = module.subnets["subnet1"].id
      public_ip_address_id = module.public_ip_address.id
    }
  ]

  tags       = local.tags
  extra_tags = local.extra_tags
}
```

## Inputs

## Inputs

| Name                            | Description                                                                                                                                                              | Type                                            | Default                                   | Required |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------- | ----------------------------------------- | :------: |
| `use_virtual_hub`              | Set to true to add virtual_hub block of settings                                                                                                                         | `bool`                                          | `false`                                   |    No    |
| `use_ip_configuration`         | Set to true to add ip_configuration block of settings                                                                                                                    | `bool`                                          | `false`                                   |    No    |
| `use_management_ip_configuration` | Set to true to add management_ip_configuration block of settings                                                                                                       | `bool`                                          | `false`                                   |    No    |
| `firewall_name`                | Specifies the name of the Firewall.                                                                                                                                      | `string`                                        | `null`                                    |   Yes    |
| `location`                     | Specifies the supported Azure location where the resource exists.                                                                                                       | `string`                                        | `null`                                    |   Yes    |
| `resource_group_name`          | The name of the resource group in which to create the resource.                                                                                                          | `string`                                        | `null`                                    |   Yes    |
| `sku_name`                     | Sku name of the Firewall. Possible values are AZFW_Hub and AZFW_VNet.                                                                                                    | `string`                                        | `null`                                    |   Yes    |
| `sku_tier`                     | Sku tier of the Firewall. Possible values are Premium and Standard.                                                                                                      | `string`                                        | `null`                                    |   Yes    |
| `firewall_policy_id`           | The ID of the Firewall Policy applied to this Firewall.                                                                                                                  | `string`                                        | `null`                                    |    No    |
| `dns_servers`                  | A list of DNS servers that the Azure Firewall will direct DNS traffic to for name resolution.                                                                          | `list(string)`                                  | `null`                                    |    No    |
| `private_ip_ranges`            | A list of SNAT private CIDR IP ranges, or the special string IANAPrivateRanges, which indicates Azure Firewall does not SNAT when the destination IP address is a private range per IANA RFC 1918. | `null`                                     | `null`                                    |    No    |
| `threat_intel_mode`            | The operation mode for threat intelligence-based filtering. Possible values are: Off, Alert, Deny, and "" (empty string).                                                    | `string`                                        | `"Alert"`                                |    No    |
| `zones`                        | Specifies the availability zones in which the Azure Firewall should be created.                                                                                        | `null`                                     | `null`                                    |    No    |
| `tags`                         | Tags to be applied to resources (inclusive).                                                                                                                              | `object({ environment = string, project = string })` | `null`                                    |    Yes    |
| `extra_tags`                   | Extra tags to be applied to resources (in addition to the tags above).                                                                                                    | `map(string)`                                  | `{}`                                      |    No    |
| `virtual_hub`                  | A list of virtual_hub blocks as defined below.                                                                                                                            | `list(object({ virtual_hub_id = string, public_ip_count = optional(number) }))` | `[]`                                      |    No    |
| `management_ip_configuration`   | A list of management_ip_configuration blocks as defined below.                                                                                                            | `list(object({ name = string, subnet_id = string, public_ip_address_id = string }))` | `[]`                                      |    No    |
| `ip_configuration`             | A list of ip_configuration blocks as defined below.                                                                                                                       | `list(object({ name = string, subnet_id = optional(string), public_ip_address_id = optional(string) }))` | `[]`                                      |    No    |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fw_id"></a> [id](#output\_fw\_id) | Firewall ID. |
| <a name="output_fw_name"></a> [name](#output\_fw\_name) | Firewall Name. |
<!-- END_TF_DOCS -->
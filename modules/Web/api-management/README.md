## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apim_name"></a> [apim\_name](#input\_apim\_name) | The name of your APIM instance | `string` | n/a | yes |
| <a name="input_apim_settings"></a> [apim\_settings](#input\_apim\_settings) | The settings block for APIM | `any` | `{}` | no |
| <a name="input_client_certificate_enabled"></a> [client\_certificate\_enabled](#input\_client\_certificate\_enabled) | Whether client ceritifcate is enabled | `bool` | `false` | no |
| <a name="input_gateway_disabled"></a> [gateway\_disabled](#input\_gateway\_disabled) | Whether gateway is disabled or not | `bool` | `null` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | Specifies a list of user managed identity ids to be assigned to the VM. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The Managed Service Identity Type of this Virtual Machine. | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | The location for this resource to be put in | `string` | n/a | yes |
| <a name="input_min_api_version"></a> [min\_api\_version](#input\_min\_api\_version) | The minimum API version | `string` | `null` | no |
| <a name="input_notification_sender_email"></a> [notification\_sender\_email](#input\_notification\_sender\_email) | The email of addresses the notification email should be sent as | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is enabled to APIM | `bool` | `true` | no |
| <a name="input_publisher_email"></a> [publisher\_email](#input\_publisher\_email) | The publisher email of APIM | `string` | n/a | yes |
| <a name="input_publisher_name"></a> [publisher\_name](#input\_publisher\_name) | The publisher name of APIM | `string` | n/a | yes |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | The name of the resource group, this module does not create a resource group, it is expecting the value of a resource group already exists | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU of the APIM, should be seperated with an underslash for scale units, e.g. Premium\_3 | `string` | `"Consumption_0"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of the tags to use on the resources that are deployed with this module. | `map(string)` | <pre>{<br>  "source": "terraform"<br>}</pre> | no |
| <a name="input_virtual_network_type"></a> [virtual\_network\_type](#input\_virtual\_network\_type) | The virtual network type | `string` | `"None"` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | The zones that the APIM is in | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_apim_addional_location"></a> [apim\_addional\_location](#output\_apim\_addional\_location) | The additional location block info if specified |
| <a name="output_apim_developer_portal_url"></a> [apim\_developer\_portal\_url](#output\_apim\_developer\_portal\_url) | The developer portal URL of APIM |
| <a name="output_apim_gateway_regional_url"></a> [apim\_gateway\_regional\_url](#output\_apim\_gateway\_regional\_url) | The regional gateway url of the APIM |
| <a name="output_apim_gateway_url"></a> [apim\_gateway\_url](#output\_apim\_gateway\_url) | The gateway url of the APIM |
| <a name="output_apim_hostname_configuration"></a> [apim\_hostname\_configuration](#output\_apim\_hostname\_configuration) | The hostname configuration block if specified |
| <a name="output_apim_id"></a> [apim\_id](#output\_apim\_id) | The id of the APIM |
| <a name="output_apim_identity"></a> [apim\_identity](#output\_apim\_identity) | The identity block of the APIM |
| <a name="output_apim_management_api_url"></a> [apim\_management\_api\_url](#output\_apim\_management\_api\_url) | The management API URL of APIM |
| <a name="output_apim_portal_url"></a> [apim\_portal\_url](#output\_apim\_portal\_url) | The APIM portal URL |
| <a name="output_apim_private_ip_addresses"></a> [apim\_private\_ip\_addresses](#output\_apim\_private\_ip\_addresses) | The private IP addresses of the APIM |
| <a name="output_apim_public_ip_addresses"></a> [apim\_public\_ip\_addresses](#output\_apim\_public\_ip\_addresses) | The public IP addresses of the APIM instance |
| <a name="output_apim_scm_url"></a> [apim\_scm\_url](#output\_apim\_scm\_url) | The SCM URL of the APIM instance |
| <a name="output_apim_tenant_access"></a> [apim\_tenant\_access](#output\_apim\_tenant\_access) | The APIM tenant access block |

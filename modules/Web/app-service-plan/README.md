# Azure - App Service Plan Module
This module will create an Azure App Service Plan.

<!--- BEGIN_TF_DOCS --->
## Requirements

 Name | Version |
------|---------|
 <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
 <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |
 <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1 |

## Providers

 Name | Version |
------|---------|
 <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.0 |
 <a name="provider_random"></a> [random](#provider\_random) | >= 3.1 |

## Modules

No modules.

## Resources

 Name | Type |
------|------|
 [azurerm_service_plan.asp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |

## Inputs

 Name | Description | Type | Default | Required |
------|-------------|------|---------|:--------:|
 <a name="input_name"></a> [name](#input\_name) | The name of the App Service Plan | `string` | n/a | yes |
 <a name="input_location"></a> [location](#input\_location) | The Azure location where the App Service Plan should be created | `string` | n/a | yes |
 <a name="input_os_type"></a> [os_type](#input\_os_type) | The type of operating system on which the App Service Plan will run | `string` | n/a | yes |
 <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | The name of the resource group in which to create the App Service Plan | `string` | n/a | yes |
 <a name="input_sku_name"></a> [sku_name](#input\_sku_name) | The SKU of the App Service Plan | `string` | n/a | yes |
 <a name="input_per_site_scaling_enabled"></a> [per_site_scaling_enabled](#input\_per_site_scaling_enabled) | Whether per-site scaling is enabled | `bool` | `false` | no |
 <a name="input_worker_count"></a> [worker_count](#input\_worker_count) | The number of workers associated with the App Service Plan | `number` | `1` | no |
 <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to resources | `map(string)` | n/a | yes |
 <a name="input_custom_tags"></a> [custom_tags](#input\_custom\_tags) | Custom tags to be applied to resources | `map(string)` | `{}` | no |

## Outputs

 Name | Description |
------|-------------|
 <a name="output_app_service_plan_id"></a> [app_service_plan_id](#output\_app_service_plan_id) | The ID of the App Service Plan |

<!--- END_TF_DOCS --->
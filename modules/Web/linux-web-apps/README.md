# Terraform Module

This Terraform module deploys a Linux Web App on Azure.

## Usage
```hcl
module "service_plan" {
  source = "/path/to/this/module"
  name = "service-plan-name"
  location = "eastus"
  os_type = "Linux"
  resource_group_name = module.resource_group.name
  sku_name = "F1"

  tags = {
    environment = "dev"
    costcenter = "it"
  }
}
```

## Resources

 Name | Type |
------|------|
 [azurerm_service_plan.asp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| linux_web_app_name | The name of the Linux Web App | `string` | n/a | yes |
| location | The location | `string` | n/a | yes |
| resource_group | The resource group name | `string` | n/a | yes |
| https_only | Whether to only allow HTTPS traffic | `bool` | `true` | no |
| enabled | Whether to enable the web app | `bool` | `true` | no |
| service_plan_id | The ID of the App Service Plan | `string` | n/a | yes |
| tags | Tags to be applied to resources (inclusive) | `object` | n/a | yes |
| custom_tags | Custom tags to be applied to resources (in addition to the tags above) | `map(string)` | `{}` | no |
| app_settings | The app settings | `map(string)` | n/a | yes |
| client_affinity_enabled | Whether client affinity is enabled | `bool` | n/a | yes |
| identity_ids | The list of user-assigned identity IDs | `list(string)` | n/a | yes |
| site_config | The site configuration | `object` | n/a | yes |
| logs | The logs configuration | `object` | n/a | yes |
| storage_account | The storage account | `list(object)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | Linux Web App ID |
| identity | Linux Web App Managed Identity |
| default_hostname | Linux Web App default hostname |

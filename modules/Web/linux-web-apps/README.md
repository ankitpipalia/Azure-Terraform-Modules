## Azure Terraform Module for Linux Web Apps

This Terraform module creates an Azure Linux Web Apps. It includes all the necessary resources for production use, except for the resource group.

## Usage
```hcl
module "linux-web-apps" {
  source = "path/to/this/module"
  name = "xyz-test-app"
  location = module.resource_group.location
  resource_group_name = module.resource_group.name
  service_plan_id = module.service_plan.id

  tags = local.tags
  custom_tags = local.custom_tags

  identity_type = "SystemAssigned"

  settings = {
    site_config = {
      minimum_tls_version = "1.2"
      http2_enabled       = true

      application_stack = {
        node_version = "18-lts"
      }
    }

    auth_settings = {
      enabled                       = false
      runtime_version               = "~1"
      unauthenticated_client_action = "AllowAnonymous"
    }
  }
}
```

## Resources

| Name | Type |
|------|------|
| [azurerm_app_service_virtual_network_swift_connection.function_vnet_integration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_virtual_network_swift_connection) | resource |
| [azurerm_linux_web_app.web_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |

## Inputs

| Name | Type | Default | Required |
|------|------|---------|:--------:|
| <a name="input_active_directory_auth_setttings"></a> [active\_directory\_auth\_setttings](#input\_active\_directory\_auth\_setttings) | `any` | `{}` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | `string` | n/a | yes |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | `map(any)` | `{}` | no |
| <a name="input_backup_sas_url"></a> [backup\_sas\_url](#input\_backup\_sas\_url) | `string` | `""` | no |
| <a name="input_builtin_logging_enabled"></a> [builtin\_logging\_enabled](#input\_builtin\_logging\_enabled) | `bool` | `true` | no |
| <a name="input_client_certificate_enabled"></a> [client\_certificate\_enabled](#input\_client\_certificate\_enabled) | `bool` | `false` | no |
| <a name="input_client_certificate_mode"></a> [client\_certificate\_mode](#input\_client\_certificate\_mode) | `string` | `"Optional"` | no |
| <a name="input_connection_strings"></a> [connection\_strings](#input\_connection\_strings) | `list(map(string))` | `[]` | no |
| <a name="input_daily_memory_time_quota"></a> [daily\_memory\_time\_quota](#input\_daily\_memory\_time\_quota) | `number` | `0` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | `bool` | `true` | no |
| <a name="input_force_disabled_content_share"></a> [force\_disabled\_content\_share](#input\_force\_disabled\_content\_share) | `bool` | `false` | no |
| <a name="input_https_only"></a> [https\_only](#input\_https\_only) | `bool` | `true` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | `string` | n/a | yes |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | `string` | n/a | yes |
| <a name="input_service_plan_id"></a> [service\_plan\_id](#input\_service\_plan\_id) | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | `any` | `false` | no |
| <a name="input_site_config"></a> [site\_config](#input\_site\_config) | `any` | `{}` | no |
| <a name="input_storage_key_vault_secret_id"></a> [storage\_key\_vault\_secret\_id](#input\_storage\_key\_vault\_secret\_id) | `string` | `""` | no |
| <a name="input_storage_uses_managed_identity"></a> [storage\_uses\_managed\_identity](#input\_storage\_uses\_managed\_identity) | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | `map(string)` | <pre>{<br>  "source": "terraform"<br>}</pre> | no |
| <a name="input_web_app_vnet_integration_enabled"></a> [web\_app\_vnet\_integration\_enabled](#input\_web\_app\_vnet\_integration\_enabled) | `bool` | `false` | no |
| <a name="input_web_app_vnet_integration_subnet_id"></a> [web\_app\_vnet\_integration\_subnet\_id](#input\_web\_app\_vnet\_integration\_subnet\_id) | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_outbound_ip_addresses"></a> [outbound\_ip\_addresses](#output\_outbound\_ip\_addresses) | A comma separated list of outbound IP addresses |
| <a name="output_possible_outbound_ip_addresses"></a> [possible\_outbound\_ip\_addresses](#output\_possible\_outbound\_ip\_addresses) | A comma separated list of outbound IP addresses. not all of which are necessarily in use |
| <a name="output_site_credential"></a> [site\_credential](#output\_site\_credential) | The output of any site credentials |
| <a name="output_web_app_id"></a> [web\_app\_id](#output\_web\_app\_id) | The ID of the App Service. |
| <a name="output_web_app_name"></a> [web\_app\_name](#output\_web\_app\_name) | The name of the App Service. |
| <a name="output_web_identity"></a> [web\_identity](#output\_web\_identity) | The managed identity block from the Function app |

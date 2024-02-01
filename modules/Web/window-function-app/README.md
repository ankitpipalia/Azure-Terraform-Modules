# Terraform Azure- Windows Function App

A Terraform module for deploying and managing an Azure Windows Function App.

## Module Usage

To use this module, include the following code in your Terraform configuration:

```hcl
module "window_function_app" {
  source                      = "path/to/module/window_function_app"
  window_function_name        = "my-function-app"
  resource_group_name         = "my-resource-group"
  location                    = "East US"
  storage_account_name        = "my-storage"
  storage_account_access_key  = ""                             # Add your storage account access key
  service_plan_id             = ""                             # Add your service plan ID
  functions_extension_version = 4                              # Use the desired version
  tags = {
    environment = "test"
    project     = "my_project"
  }
}


```

## Resources

This module deploys the following Azure resources:

- [azurerm_windows_function_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_function_app)

## Inputs

| Variable Name                                  | Description                                                                              | Type       | Default         | Required |
|------------------------------------------------|------------------------------------------------------------------------------------------|------------|-----------------|----------|
| `window_function_name`                         | Specifies the name of the Windows Function App.                                          | string     |                 | Yes      |
| `resource_group_name`                           | The name of the Resource Group where the Windows Function App will be deployed.          | string     |                 | Yes      |
| `location`                                     | The Azure Region where the Windows Function App will be deployed.                         | string     |                 | Yes      |
| `app_settings`                                 | Function App application settings.                                                        | map(any)    | `{}`            | No       |
| `builtin_logging_enabled`                       | Whether AzureWebJobsDashboards should be enabled, default is true.                        | bool       | `true`          | No       |
| `client_certificate_enabled`                    | Whether client certificate auth is enabled, default is false.                             | bool       | `false`         | No       |
| `client_certificate_mode`                       | The option for client certificates.                                                       | string     | `Optional`    | No       |
| `client_certificate_exclusion_paths`           | Paths to exclude when using client certificates, separated by `;`.                        | string     | `null`          | No       |
| `content_share_force_disabled`                 | Should Content Share Settings be disabled.                                               | bool       | `false`         | No       |
| `daily_memory_time_quota`                      | The amount of memory in gigabyte-seconds that your app can consume per day, defaults to 0. | number     | `0`             | No       |
| `enabled`                                      | Is the function app enabled? Default is true.                                            | bool       | `true`          | No       |
| `ftp_publish_basic_authentication_enabled`     | Should the default FTP Basic Authentication publishing profile be enabled.              | bool       | `true`          | No       |
| `functions_extension_version`                  | The function extension version.                                                          | string     |                 | No       |
| `https_only`                                   | Disable http protocol and keep only https.                                               | bool       | `true`          | No       |
| `public_network_access_enabled`                | Should public network access be enabled for the Function App.                             | bool       | `true`          | No       |
| `key_vault_reference_identity_id`             | The User Assigned Identity ID used for accessing KeyVault secrets.                         | string     | `null`          | No       |
| `storage_uses_managed_identity`                | If you want the storage account to use a managed identity instead of an access key.        | bool       | `false`         | No       |
| `storage_key_vault_secret_id`                  | The secret ID for the connection string of the storage account used by the function app.   | string     | `""`            | No       |
| `virtual_network_subnet_id`                    | ID of the subnet to associate with the Function App (VNet integration).                   | string     | `null`          | No       |
| `zip_deploy_file`                              | The local path and filename of the Zip packaged application to deploy to this Function App.| string  | `null`          | No       |
| `settings`                                     | Specifies the Authentication enabled or not.                                             | bool       | `false`         | No       |
| `auth_settings`                                | Authentication settings.                                                                 | map(any)    |             | No       |
| `connection_strings`                           | Connection strings for App Service.                                                      | list(map(string)) |    | No       |
| `sticky_settings`                              | Sticky settings for App Service.                                                          | map(any)    |             | No       |
| `backup`                                      | Backup settings for App Service.                                                          | map(any)    |             | No       |
| `identity_ids`                                 | Specifies a list of user managed identity ids to be assigned to the VM.                   | list(string)|             | No       |
| `identity_type`                                | The Managed Service Identity Type of this Virtual Machine.                                | string     |            | No       |
| `tags`                                         | Tags to be applied to resources (inclusive).                                             | object     |             | No       |
| `extra_tags`                                   | Extra tags to be applied to resources (in addition to the tags above).                     | map(string)|            | No       |


# Outputs

| Name                   | Description                                                       |
|------------------------|-------------------------------------------------------------------|
| `window_function_name` | The name of the Windows Function App.                             |
| `resource_group_name`  | The name of the resource group where the Windows Function App is deployed. |
| `location`             | The Azure region in which the Windows Function App is deployed.   |
| `site_config`          | Configuration settings for the Windows Function App.              |
| `site_credentials`     | Credentials associated with the Windows Function App's site.      |

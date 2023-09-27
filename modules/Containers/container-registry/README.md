## Azure Terraform Module for Container Registry

This module creates a container registry in Azure.

## Usage
```hcl
module "azurerm_container_registry" {
  source = "./modules/Containers/container-registry"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  container_registry_config = {
    name = "xyzabctestregistry"
    admin_enabled = true
    sku = "Premium"
    public_network_access_enabled = true
    quarantine_policy_enabled = true
    zone_redundancy_enabled = true
  }

  tags                = local.tags
  extra_tags          = local.extra_tags

}
```

## Inputs

| Name                          | Description                                                                                                      | Type     | Default  | Required |
|-------------------------------|------------------------------------------------------------------------------------------------------------------|----------|----------|----------|
| `resource_group_name`         | The name of the Azure Resource Group where the container registry will be created.                             | string   |          | Yes      |
| `location`                    | The Azure region where the container registry will be created.                                                 | string   |          | Yes      |
| `container_registry_config`   | Configuration for the Azure Container Registry.                                                                | object   |          | Yes      |
| `georeplications`             | A map of georeplication configurations for the container registry.                                               | map      | {}       | No       |
| `network_rule_set`            | Configuration for network rules for the container registry.                                                      | object   | null     | No       |
| `retention_policy`            | Configuration for the retention policy of container images.                                                      | object   | null     | No       |
| `trust_policy`                | Configuration for content trust policy.                                                                         | bool     | false    | No       |
| `identity_ids`                | A list of User Assigned Managed Identity IDs.                                                                   | list     | null     | No       |
| `encryption`                  | Configuration for encryption settings.                                                                          | object   | null     | No       |
| `scope_map`                   | A map of scope maps for the container registry.                                                                 | map      | null     | No       |
| `container_registry_webhooks` | A map of webhook configurations for the container registry.                                                      | map      | null     | No       |
| `tags`                        | A map of tags to apply to the Azure Container Registry.                                                          | map      | {}       | No       |
| `extra_tags`                  | Additional tags to apply to the Azure Container Registry.                                                         | map      | {}       | No       |
| `enable_content_trust`        | Enable content trust for the container registry.                                                                | bool     | false    | No       |

## Outputs

| Name                                   | Description                                                                                                 |
|----------------------------------------|-------------------------------------------------------------------------------------------------------------|
| `container_registry_id`                | The ID of the Container Registry.                                                                          |
| `container_registry_login_server`       | The URL that can be used to log into the container registry.                                                |
| `container_registry_admin_username`     | The Username associated with the Container Registry Admin account if the admin account is enabled.        |
| `container_registry_admin_password`     | The Password associated with the Container Registry Admin account if the admin account is enabled.        |
| `container_registry_identity_principal_id` | The Principal ID for the Service Principal associated with the Managed Service Identity of this Container Registry. |
| `container_registry_identity_tenant_id`   | The Tenant ID for the Service Principal associated with the Managed Service Identity of this Container Registry.   |
| `container_registry_scope_map_id`       | The ID of the Container Registry scope map.                                                                |
| `container_registry_token_id`           | The ID of the Container Registry token.                                                                    |
| `container_registry_webhook_id`         | The ID of the Container Registry Webhook.                                                                  |

# Azure Terraform Module for Azure Service Plan

This Terraform module creates an Azure Service Plan. It includes all the necessary resources for production use, except for the resource group.

## Usage
```hcl
module "static_site" {
  source = "./modules/Web/static-web-apps"

  static_site_name = "test-static-site"
  location = "eastasia"
  resource_group = module.resource_group.name
  tags = local.tags
  extra_tags = local.extra_tags
}
```

## Inputs

| Name               | Description                                      | Type   | Default             | Required |
|--------------------|--------------------------------------------------|--------|---------------------|:--------:|
| `static_site_name` | The name of the Azure Static Site.              | string | -                   | yes      |
| `location`         | The Azure region where the site should be hosted. | string | -                   | yes      |
| `resource_group`   | The name of the Azure Resource Group.           | string | -                   | yes      |
| `sku_tier`         | The pricing tier of the Static Site.            | string | -                   | yes      |
| `sku_size`         | The size of the Static Site.                    | string | -                   | yes      |
| `tags`             | Additional tags to apply to the Static Site.    | map    | `{}`                | no       |
| `extra_tags`       | Extra tags to merge with the default tags.      | map    | `{}`                | no       |
| `identity_ids`     | The Azure Managed Identity IDs.                 | string | `null` (SystemAssigned) | no       |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_static_site_api_key"></a> [static\_site\_api\_key](#output\_static\_site\_api\_key) | The API key of this Static Web App, which is used for later interacting with this Static Web App from other clients, e.g. GitHub Action. |
| <a name="output_static_site_default_host_name"></a> [static\_site\_default\_host\_name](#output\_static\_site\_default\_host\_name) | The default host name of the Static Web App. |
| <a name="output_static_site_id"></a> [static\_site\_id](#output\_static\_site\_id) | The ID of the Static Web App |
| <a name="output_static_site_identity"></a> [static\_site\_identity](#output\_static\_site\_identity) | An identity block as defined below which contains the Managed Service Identity information for this resource. |
<!-- END_TF_DOCS -->

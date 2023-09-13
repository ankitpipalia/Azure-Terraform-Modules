# Module - Private DNS Zone
[![COE](https://img.shields.io/badge/Created%20By-CCoE-blue)]()
[![HCL](https://img.shields.io/badge/language-HCL-blueviolet)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/provider-Azure-blue)](https://registry.terraform.io/providers/hashicorp/azurerm/latest)

Module developed to standardize the Private DNS Zone and Virtual Network Link Creation.

## Compatibility Matrix

| Module Version | Terraform Version | AzureRM Version |
|----------------|-------------------| --------------- |
| v1.0.0         | v1.3.7            | 3.48.0          |

## Specifying a version

To avoid that your code get updates automatically, is mandatory to set the version using the `source` option. 
By defining the `?ref=***` in the the URL, you can define the version of the module.

Note: The `?ref=***` refers a tag on the git module repo.

## Use case
```hcl
module "zone_name" {
  source    = "git::https://github.com/danilomnds/terraform-azurerm-private-dns-zone?ref=v1.0.0"
  name     = <private zone name>
  resource_group_name = <resource group name>
  virtual_network_link = {
    pvlink-name = {
            name            = <pvlink-name>
            registration_enabled = "false"
            virtual_network_id   = <vnetid>
    }
    pvlink-name2 = {
            name            = <pvlink-name2>
            registration_enabled = "false"
            virtual_network_id   = <vnetid>
    }  
  }
}
output "dns_id" {
  value = module.zone_name.dns_zone_id
}
output "private_link_ids" {
  value = module.zone_name.virtual_network_link_id
}
```

## Input variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | private link name | `string` | n/a | `Yes` |
| resource_group_name | resource group name | `string` | n/a | `Yes` |
| soa_record | possible parameters for soa_record (full list of parameters below) | `object()` | n/a | No |
| tags | tags | `map(any)` | `{}` | No |
| virtual_network_link | parameters for the creation of the virtual network link soa_record (full list of parameters below) | `map(object())` | n/a | No |

## List of parameters that can be defined for the soa record (soa_record var)

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| email | the email contact for the SOA record | `string` | n/a | `Yes` |
| expire_time | the expire time for the SOA record | `number` | 2419200 | No |
| minimum_ttl | the minimum ttl for the SOA record | `number` | 10 | No |
| refresh_time | the refresh time for the SOA record | `number` | 3600 | No |
| retry_time | the retry time for the SOA record | `number` | 300 | No |
| ttl | the Time To Live of the SOA Record in seconds | `number` | 3600 | No |
| tags | a mapping of tags to assign to the Record Se | `map(string)` | n/a | No |

## List of parameters that can be defined for the creation of virtual network links (virtual_network_link var)

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | the name of the private DNS zone virtual network link | `string` | n/a | `Yes` |
| private_dns_zone_name | the name of the private DNS zone | `string` | private zone created using this module | No |
| resource_group_name | resource group name | `string` | the rg for the private zone created using this module | No |
| virtual_network_id | the ID of the virtual network that should be linked to the DNS Zone | `string` | n/a | `Yes` |
| registration_enabled | is auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled | `bool` | false | No |
| tags | a mapping of tags to assign to the Record Se | `map(string)` | n/a | No |

## Output variables

| Name | Description |
|------|-------------|
| cluster_name | cluster name |
| dns_zone_id | private DNS zone id |
| virtual_network_link_id | virtual network link ids |

## Documentation

Terraform Private DNS: <br>
[https://registry.terraform.io/providers/azurerm/latest/docs/resources/dns_zone](https://registry.terraform.io/providers/azurerm/latest/docs/resources/dns_zone)

[https://registry.terraform.io/providers/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link](https://registry.terraform.io/providers/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link)
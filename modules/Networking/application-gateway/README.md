
# Azure Application Gateway Terraform Module 

A Terraform module which creates an Application Gateway on Azure with the following characteristics:

## Usage

# Application Gateway Creation example:

```hcl
module "application_gateway" {
  source = "./modules/Networking/application-gateway"

  application_gateway_name = "test-app-gateway"
  resource_group_name      = module.resource_group.name
  location                 = module.resource_group.location

  sku = {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration_name = "test-gateway-ip-configuration"
  subnet_id = module.subnets["appgw"].id

  frontend_ip_configuration_name = "test-frontend-ip-configuration"
  public_ip_address_id = module.public_ip_address.id

  backend_address_pools = [
    {
      name = "test-backend-address-pool"
    }
  ]

  backend_http_settings = [
    {
      name                  = "test-http-settings"
      cookie_based_affinity = "Disabled"
      enable_https = true
      request_timeout       = 30
    }
  ]

  http_listeners = [
    {
      name                           = "test-http-listener"
      frontend_ip_configuration_name = "test-frontend-ip-configuration"
      frontend_port_name             = "test-frontend-port"
      protocol                       = "Http"
    }
  ]

  request_routing_rules = [
    {
      name                       = "test-request-routing-rule"
      rule_type                  = "Basic"
      http_listener_name         = "test-http-listener"
      backend_address_pool_name  = "test-backend-address-pool"
      backend_http_settings_name = "test-http-settings"
      priority                   = 1
    }
  ]

  tags       = local.tags
  extra_tags = local.extra_tags
}
```

## Inputs

| Name                                    | Description                                                               | Type     | Default | Required |
|-----------------------------------------|---------------------------------------------------------------------------|----------|---------|:--------:|
| `agw_diag_logs`                         | Application Gateway Monitoring Category details for Azure Diagnostic setting. | list(string) | ["ApplicationGatewayAccessLog", "ApplicationGatewayPerformanceLog", "ApplicationGatewayFirewallLog"] | no |
| `application_gateway_name`              | The name of the application gateway.                                      | string   | -       | yes      |
| `authentication_certificates`           | Authentication certificates to allow the backend with Azure Application Gateway. | list(object) | [] | no |
| `autoscale_configuration`               | Minimum or Maximum capacity for autoscaling. Accepted values are for Minimum in the range 0 to 100 and for Maximum in the range 2 to 125. | object | null | no |
| `backend_address_pools`                 | List of backend address pools.                                            | list(object) | -       | yes      |
| `backend_http_settings`                 | List of backend HTTP settings.                                            | list(object) | -       | yes      |
| `category_list_metrics`                 | Category list metrics.                                                    | list(any) | ["Basic", "WorkloadManagement"] | no |
| `collation`                             | Specifies the collation of the database.                                  | string   | "SQL_Latin1_General_CP1_CI_AS" | no |
| `create_resource_group`                 | Whether to create a resource group and use it for all networking resources. | bool     | false | no       |
| `custom_error_configuration`            | Global level custom error configuration for application gateway.           | list(map(string)) | [] | no |
| `databases`                             | Map of databases.                                                         | map(map(string)) | {} | no |
| `destination_type`                      | Log analytics destination type.                                           | string   | "Dedicated" | no |
| `disable_bgp_route_propagation`         | Boolean flag that controls propagation of routes learned by BGP on the route table. | bool | true | no |
| `domain_name_label`                    | Label for the Domain Name. Will be used to make up the FQDN.              | string | null | no |
| `enable_http2`                         | Is HTTP2 enabled on the application gateway resource?                    | bool | false | no |
| `extra_tags`                            | Extra tags to be applied to resources in addition to the tags above.      | map(string) | {} | no |
| `firewall_policy_id`                    | The ID of the Web Application Firewall Policy which can be associated with the app gateway. | string | null | no |
| `frontend_ip_configuration_name`        | The name of the frontend IP configuration.                                | string   | -       | yes      |
| `gateway_ip_configuration_name`         | The name of the gateway IP configuration.                                 | string   | -       | yes      |
| `health_probes`                        | List of Health probes used to test backend pools health.                 | list(object) | [] | no |
| `http_listeners`                       | List of HTTP/HTTPS listeners. SSL Certificate name is required.           | list(object) | -       | yes      |
| `identity_ids`                         | Specifies a list with a single user managed identity id to be assigned to the Application Gateway. | string | null | no |
| `ip_rules`                             | Map of IP addresses permitted for access to DB.                            | map(string) | {} | no |
| `key_vault_id`                         | Key Vault ID.                                                             | string | null | no |
| `key_vault_key_id`                     | Key Vault Key id for transparent data encryption of the server.            | string | null | no |
| `location`                             | The location/region to keep all your network resources.                   | string | - | yes      |
| `log_analytics_workspace_id`            | The name of log analytics workspace name.                                 | string | null | no |
| `log_category_list`                    | Category list log.                                                        | list(any) | ["QueryStoreRuntimeStatistics", "QueryStoreWaitStatistics", "Errors", "DatabaseWaitStatistics", "Timeouts", "Blocks", "Deadlocks"] | no |
| `log_retention_days`                   | Retention log policy days.                                                | number | 7 | no       |
| `max_size`                             | The max size of the database in gigabytes.                                 | string | - | yes      |
| `metric_retention_days`                | Retention metric policy days.                                             | number | 7 | no       |
| `min_capacity`                         | The min size of the database in gigabytes.                                 | string | - | yes      |
| `minimum_tls_version`                  | The Minimum TLS Version for all SQL Database and SQL Data Warehouse databases associated with the server. | string | "1.2" | no |
| `private_ip_address`                   | Private IP Address to assign to the Load Balancer.                         | string | null | no |
| `public_ip_address_id`                 | The ID of the public IP address to associate with the Application Gateway. | string | - | yes      |
| `redirect_configuration`               | List of maps for redirect configurations.                                 | list(map(string)) | [] | no |
| `request_routing_rules`                | List of Request routing rules to be used for listeners.                   | list(object) | [] | no |
| `rewrite_rule_set`                     | List of rewrite rule set including rewrite rules.                          | any | [] | no |
| `routes`                               | List of objects that represent the configuration of each route.            | list(map(string)) | [] | no |
| `server_fqdn`                         | FQDN of Azure SQL Server.                                                  | string | - | yes      |
| `server_id`                            | Id of SQL server.                                                         | string | - | yes      |
| `server_version`                       | Server version.                                                           | string | "12.0" | no |
| `sku`                                  | The sku pricing model of v1 and v2.                                       | object | - | yes      |
| `ssl_certificates`                     | List of SSL certificates data for Application gateway.                    | list(object) | [] | no |
| `ssl_policy`                           | Application Gateway SSL configuration.                                     | object | null | no |
| `subnet_id`                            | The ID of the subnet to associate with the Application Gateway.           | string | - | yes      |
| `subnet_name`                          | The name of the subnet to use in VM scale set.                             | string | "" | no       |
| `tags`                                 | Tags to be applied to resources (inclusive).                               | object | - | yes      |
| `trusted_root_certificates`             | Trusted root certificates to allow the backend with Azure Application Gateway. | list(object) | [] | no |
| `url_path_maps`                        | List of URL path maps associated with path-based rules.                    | list(object) | [] | no |
| `vnet_resource_group_name`              | The resource group name where the virtual network is created.             | string | null | no |
| `virtual_network_name`                 | The name of the virtual network.                                           | string | "" | no       |
| `waf_configuration`                    | Web Application Firewall support for your Azure Application Gateway.       | object | null | no |
| `zones`                                | A collection of availability zones to spread the Application Gateway over. | list(string) | [] | no |
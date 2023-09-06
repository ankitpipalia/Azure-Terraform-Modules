# Azure Load Balancer Terraform Module

This Terraform module deploys an Azure Load Balancer in Azure with production-level features.

## Prerequisites

- Azure subscription
- Terraform installed

## Usage

```hcl
module "load_balancer" {
  source                = "path/to/module"
  load_balancer_name    = "my-load-balancer"
  location              = "eastus"
  resource_group_name   = "my-resource-group"
  load_balancer_sku     = "Standard"
  frontend_ip_configuration_name = "frontend-ip-config"
  subnet_id             = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-resource-group/providers/Microsoft.Network/virtualNetworks/my-vnet/subnets/my-subnet"
  private_ip_address_allocation = "Dynamic"
  private_ip_address    = ""
  backend_address_pool_name = "backend-pool"
  probe_name            = "probe"
  probe_protocol        = "Http"
  probe_port            = 80
  probe_interval        = 15
  probe_number_of_probes = 2
  probe_request_path    = "/"
  probe_protocol_match  = "Any"
  probe_ignore_https_server_name = false
  probe_match_body      = ""
  probe_match_status_codes = [200, 201, 202]
  probe_min_servers     = 1
  probe_max_servers     = 3
  probe_healthy_http_response = ""
  probe_unhealthy_http_response = ""
  probe_healthy_http_response_win = ""
  probe_unhealthy_http_response_win = ""
  load_balancing_rule_name = "lb-rule"
  load_balancing_rule_frontend_port = 80
  load_balancing_rule_backend_port = 8080
  load_balancing_rule_protocol = "Tcp"
  tags = {
    Environment = "Production"
    Department  = "IT"
  }
}

output "load_balancer_id" {
  value = module.load_balancer.load_balancer_id
}

output "frontend_ip_configuration_id" {
  value = module.load_balancer.frontend_ip_configuration_id
}

output "backend_address_pool_id" {
  value = module.load_balancer.backend_address_pool_id
}

output "probe_id" {
  value = module.load_balancer.probe_id
}

output "load_balancing_rule_id" {
  value = module.load_balancer.load_balancing_rule_id
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| load_balancer_name | The name of the Azure Load Balancer | `string` | n/a | yes |
| location | The location/region where the Azure Load Balancer will be created | `string` | n/a | yes |
| resource_group_name | The name of the resource group where the Azure Load Balancer will be created | `string` | n/a | yes |
| load_balancer_sku | The SKU of the Azure Load Balancer | `string` | n/a | yes |
| frontend_ip_configuration_name | The name of the frontend IP configuration | `string` | n/a | yes |
| subnet_id | The ID of the subnet where the Azure Load Balancer will be deployed | `string` | n/a | yes |
| private_ip_address_allocation | The allocation method for the private IP address | `string` | n/a | yes |
| private_ip_address | The private IP address for the frontend IP configuration | `string` | n/a | yes |
| backend_address_pool_name | The name of the backend address pool | `string` | n/a | yes |
| probe_name | The name of the probe | `string` | n/a | yes |
| probe_protocol | The protocol used for the probe | `string` | n/a | yes |
| probe_port | The port used for the probe | `number` | n/a | yes |
| probe_interval | The interval (in seconds) between probe requests | `number` | n/a | yes |
| probe_number_of_probes | The number of consecutive probe failures required to mark a backend as unhealthy | `number` | n/a | yes |
| probe_request_path | The path used for the probe request | `string` | n/a | yes |
| probe_protocol_match | The protocol match condition for the probe | `string` | n/a | yes |
| probe_ignore_https_server_name | Whether to ignore the HTTPS server name during the probe | `bool` | n/a | yes |
| probe_match_body | The body match condition for the probe | `string` | n/a | yes |
| probe_match_status_codes | The status codes to match for the probe | `list(number)` | n/a | yes |
| probe_min_servers | The minimum number of healthy servers required for the probe | `number` | n/a | yes |
| probe_max_servers | The maximum number of healthy servers required for the probe | `number` | n/a | yes |
| probe_healthy_http_response | The healthy HTTP response for the probe | `string` | n/a | yes |
| probe_unhealthy_http_response | The unhealthy HTTP response for the probe | `string` | n/a | yes |
| probe_healthy_http_response_win | The healthy HTTP response for the probe (Windows) | `string` | n/a | yes |
| probe_unhealthy_http_response_win | The unhealthy HTTP response for the probe (Windows) | `string` | n/a | yes |
| load_balancing_rule_name | The name of the load balancing rule | `string` | n/a | yes |
| load_balancing_rule_frontend_port | The frontend port for the load balancing rule | `number` | n/a | yes |
| load_balancing_rule_backend_port | The backend port for the load balancing rule | `number` | n/a | yes |
| load_balancing_rule_protocol | The protocol used for the load balancing rule | `string` | n/a | yes |
| tags | Tags to apply to the Azure Load Balancer | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| load_balancer_id | The ID of the Azure Load Balancer |
| frontend_ip_configuration_id | The ID of the frontend IP configuration |
| backend_address_pool_id | The ID of the backend address pool |
| probe_id | The ID of the probe |
| load_balancing_rule_id | The ID of the load balancing rule |

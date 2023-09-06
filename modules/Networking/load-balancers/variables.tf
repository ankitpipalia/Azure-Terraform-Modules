variable "load_balancer_name" {
  description = "The name of the Azure Load Balancer"
  type        = string
}

variable "location" {
  description = "The location/region where the Azure Load Balancer will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the Azure Load Balancer will be created"
  type        = string
}

variable "load_balancer_sku" {
  description = "The SKU of the Azure Load Balancer"
  type        = string
}

variable "frontend_ip_configuration_name" {
  description = "The name of the frontend IP configuration"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the Azure Load Balancer will be deployed"
  type        = string
}

variable "private_ip_address_allocation" {
  description = "The allocation method for the private IP address"
  type        = string
}

variable "private_ip_address" {
  description = "The private IP address for the frontend IP configuration"
  type        = string
}

variable "backend_address_pool_name" {
  description = "The name of the backend address pool"
  type        = string
}

variable "probe_name" {
  description = "The name of the probe"
  type        = string
}

variable "probe_protocol" {
  description = "The protocol used for the probe"
  type        = string
}

variable "probe_port" {
  description = "The port used for the probe"
  type        = number
}

variable "probe_interval" {
  description = "The interval (in seconds) between probe requests"
  type        = number
}

variable "probe_number_of_probes" {
  description = "The number of consecutive probe failures required to mark a backend as unhealthy"
  type        = number
}

variable "probe_request_path" {
  description = "The path used for the probe request"
  type        = string
}

variable "probe_protocol_match" {
  description = "The protocol match condition for the probe"
  type        = string
}

variable "probe_ignore_https_server_name" {
  description = "Whether to ignore the HTTPS server name during the probe"
  type        = bool
}

variable "probe_match_body" {
  description = "The body match condition for the probe"
  type        = string
}

variable "probe_match_status_codes" {
  description = "The status codes to match for the probe"
  type        = list(number)
}

variable "probe_min_servers" {
  description = "The minimum number of healthy servers required for the probe"
  type        = number
}

variable "probe_max_servers" {
  description = "The maximum number of healthy servers required for the probe"
  type        = number
}

variable "probe_healthy_http_response" {
  description = "The healthy HTTP response for the probe"
  type        = string
}

variable "probe_unhealthy_http_response" {
  description = "The unhealthy HTTP response for the probe"
  type        = string
}

variable "probe_healthy_http_response_win" {
  description = "The healthy HTTP response for the probe (Windows)"
  type        = string
}

variable "probe_unhealthy_http_response_win" {
  description = "The unhealthy HTTP response for the probe (Windows)"
  type        = string
}

variable "load_balancing_rule_name" {
  description = "The name of the load balancing rule"
  type        = string
}

variable "load_balancing_rule_frontend_port" {
  description = "The frontend port for the load balancing rule"
  type        = number
}

variable "load_balancing_rule_backend_port" {
  description = "The backend port for the load balancing rule"
  type        = number
}

variable "load_balancing_rule_protocol" {
  description = "The protocol used for the load balancing rule"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Azure Load Balancer"
  type        = map(string)
}

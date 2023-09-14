variable "lb_name" {
  description = "Name used to create all resources except subnets"
}

variable "resource_group_name" {
  description = "Name of Resource group to which data will be collected"
}

variable "location" {
  description = "Define the location where to deploy LB."
}

variable "lb_type" {
  type        = string
  description = "Define which type of Load Balancer will be provided"
  default     = "public"
}

variable "pubip_address_alloc" {
  description = "Define which type of Public IP address Allocation will be used. Valid options are Static, Dynamic."
  default     = "Static"
}

variable "ft_name" {
  description = "Define the name of Frontend IP Configuration"
}

variable "lb_probes_protocol" {
  description = "Specifies the protocol of the end point."
  default     = "Http"
}

variable "lb_probes_port" {
  description = "Specifies the port on which the Probe queries the backend endpoint"
  default     = "80"
}

variable "lb_probes_path" {
  description = "Specifiers the URI used for requesting health status from the backend endpoint"
  default     = "/"
}

variable "lb_rule_proto" {
  description = "Specifies the transport protocol for the external endpoint."
  default     = "Tcp"
}

variable "lb_rule_ft_port" {
  description = "Specifies the port for the external endpoint"
  default     = "80"
}

variable "lb_rule_bck_port" {
  description = "Specifies the port used for internal connections on the endpoint"
}

variable "tags" {
  description = "Tags to be applied to resources (inclusive)"
  type = object({
    environment = string
    project     = string
  })
}

variable "extra_tags" {
  description = "extra tags to be applied to resources (in addition to the tags above)"
  type        = map(string)
  default     = {}
}


variable "subnet_id" {
  description = "Define Subnet that will be used for NIC configuration"
  default     = ""
}

variable "ft_priv_ip_addr" {
  description = "Define the Private IP Address that will be used for the Front End "
  default     = ""
}

variable "ft_priv_ip_addr_alloc" {
  description = "Speicifies how the private Ip address will be allocated"
  default     = "Static"
}

variable "public_ip_id" {
  description = "Define Public IP Address that will be used for NIC configuration"
  default     = ""
}

variable "lb_nat_pool_enabled" {
  description = "Define if NAT Pool will be created"
  default     = false
}

variable "nat_pool_frontend_ports" {
  description = "Define the Frontend Ports that will be used for NAT Pool"
  type        = list(number)
  default     = [50000, 50001]
}

variable "os_flavor" {
  description = "Define the OS Flavor that will be used for NAT Pool"
  default     = "linux"
}

variable "lb_probe_enabled" {
  description = "Define if Probe will be created"
  default     = false
}

variable "load_balancer_health_probe_port" {
  description = "Port on which the Probe queries the backend endpoint. Default `80`"
  default     = 80
}

variable "lb_probe_protocol" {
  description = "Specifies the protocol of the end point. Possible values are `Http`, `Https` or `Tcp`. If `Tcp` is specified, a received ACK is required for the probe to be successful. If `Http` is specified, a `200 OK` response from the specified `URI` is required for the probe to be successful."
  default     = null
}

variable "lb_nb_probes" {
  description = "The number of failed probe attempts after which the backend endpoint is removed from rotation. The default value is `2`. `NumberOfProbes` multiplied by `intervalInSeconds` value must be greater or equal to 10.Endpoints are returned to rotation when at least one probe is successful."
  default     = null
}

variable "lb_probe_request_path" {
  description = "Specifies the URI used for requesting health status from the backend endpoint. Required if `protocol` is set to `Http` or `Https`."
  default     = null
}
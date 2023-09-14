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

variable "name" {
  type        = string
  description = "The name of the route table."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the route table."
}

variable "location" {
  type        = string
  description = "The location/region where the route table is created."
}

variable "routes" {
  type        = list(map(string))
  default     = []
  description = "List of objects that represent the configuration of each route."
  /*ROUTES = [{ name = "", address_prefix = "", next_hop_type = "", next_hop_in_ip_address = "" }]*/
}


variable "disable_bgp_route_propagation" {
  type        = bool
  default     = true
  description = "Boolean flag which controls propagation of routes learned by BGP on that route table."
}

variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet to associate with the Route Table."
}
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

variable "private_endpoint_name" {
  description = "The name of the private endpoint."
  type        = string
}

variable "location" {
  description = "The location/region in which to create the private endpoint."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the private endpoint."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet in which to create the private endpoint."
  type        = string
}

variable "private_service_connection_name" {
  description = "The name of the private service connection."
  type        = string
}

variable "private_connection_resource_id" {
  description = "The resource ID of the private connection."
  type        = string
}

variable "is_manual_connection" {
  description = "Boolean flag to indicate if the connection is manual."
  type        = bool
  default     = false
}

variable "subresource_names" {
  description = "A list of subresource names which the Private Endpoint is able to connect to."
  type        = list(string)
  default     = null
}

variable "private_dns_zone_group_name" {
  description = "The name of the private DNS zone group."
  type        = string
}

variable "private_dns_zone_ids" {
  description = "A list of private DNS zone IDs to associate with the private endpoint."
  type        = list(string)
  default     = []  # An example default value, adjust as needed
}

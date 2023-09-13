variable "location" {
  type        = string
  description = "Azure location"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group"
}

variable "nat_gateway_name" {
  type        = string
  description = "Name of NAT Gateway"
}

variable "nat_sku" {
  type        = string
  description = "SKU of NAT Gateway"
  default = "Standard"
}

variable "nat_idle_time" {
  type        = number
  description = "Idle timeout of NAT Gateway"
  default = 10
}

variable "nat_zones" {
  type        = list(string)
  description = "Zones of NAT Gateway"
  default     = []
}

variable "public_ip_address_id" {
  type        = string
  description = "Public IP address id"
}

variable "tags" {
  description = "Tags to be applied to resources (inclusive)"
  type        = object({
    environment         = string
    project        = string
  })
}

variable "extra_tags" {
  description = "extra tags to be applied to resources (in addition to the tags above)"
  type        = map(string)
  default     = {}
}

variable "subnet_id" {
  type        = string
  description = "Subnet id"
}
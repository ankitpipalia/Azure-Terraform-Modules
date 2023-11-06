variable "use_virtual_hub" {
  description = "Set to true to add virtual_hub block of settings"
  type        = bool
  default     = false
}

variable "use_ip_configuration" {
  description = "Set to true to add ip_configuration block of settings"
  type        = bool
  default     = false
}

variable "use_management_ip_configuration" {
  description = "Set to true to add management_ip_configuration block of settings"
  type        = bool
  default     = false
}

variable "firewall_name" {
  description = "Specifies the name of the Firewall."
  type        = string
  default     = null
}

variable "location" {
  description = " Specifies the supported Azure location where the resource exists."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the resource."
  type        = string
  default     = null
}

variable "sku_name" {
  description = "Sku name of the Firewall. Possible values are AZFW_Hub and AZFW_VNet."
  type        = string
  default     = null
}

variable "sku_tier" {
  description = "Sku tier of the Firewall. Possible values are Premium and Standard."
  type        = string
  default     = null
}

variable "firewall_policy_id" {
  description = "The ID of the Firewall Policy applied to this Firewall."
  type        = string
  default     = null
}

variable "dns_servers" {
  description = "A list of DNS servers that the Azure Firewall will direct DNS traffic to the for name resolution."
  type        = list(string)
  default     = null
}

variable "private_ip_ranges" {
  description = "A list of SNAT private CIDR IP ranges, or the special string IANAPrivateRanges, which indicates Azure Firewall does not SNAT when the destination IP address is a private range per IANA RFC 1918."
  default     = null
}

variable "threat_intel_mode" {
  description = "The operation mode for threat intelligence-based filtering. Possible values are: Off, Alert,Deny and \"\"(empty string)"
  type        = string
  default     = "Alert"
}

variable "zones" {
  description = "Specifies the availability zones in which the Azure Firewall should be created."
  default     = null
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

variable "virtual_hub" {
  description = "A list of virtual_hub blocks as defined below."
  type = list(object({
    virtual_hub_id  = string
    public_ip_count = number
  }))
  default = []
}

variable "management_ip_configuration" {
  description = "A list of management_ip_configuration blocks as defined below."
  type = list(object({
    name                 = string
    subnet_id            = string
    public_ip_address_id = string
  }))
  default = []
}

variable "ip_configuration" {
  description = "A list of ip_configuration blocks as defined below."
  type = list(object({
    name                 = string
    subnet_id            = string
    public_ip_address_id = string
  }))
  default = []
}

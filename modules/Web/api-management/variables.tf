variable "apim_name" {
  type        = string
  description = "The name of your APIM instance"
}

variable "apim_settings" {
  type        = any
  description = "The settings block for APIM"
  default     = {}
}

variable "client_certificate_enabled" {
  type        = bool
  description = "Whether client ceritifcate is enabled"
  default     = false
}

variable "gateway_disabled" {
  type        = bool
  description = "Whether gateway is disabled or not"
  default     = null
}

variable "identity_ids" {
  description = "Specifies a list of user managed identity ids to be assigned to the VM."
  type        = list(string)
  default     = []
}

variable "identity_type" {
  description = "The Managed Service Identity Type of this Virtual Machine."
  type        = string
  default     = "SystemAssigned"
}

variable "location" {
  description = "The location for this resource to be put in"
  type        = string
}

variable "min_api_version" {
  type        = string
  description = "The minimum API version"
  default     = null
}

variable "notification_sender_email" {
  type        = string
  description = "The email of addresses the notification email should be sent as"
  default     = null
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is enabled to APIM"
  default     = true
}

variable "publisher_email" {
  type        = string
  description = "The publisher email of APIM"
}

variable "publisher_name" {
  type        = string
  description = "The publisher name of APIM"
}

variable "resource_group_name" {
  description = "The name of the resource group, this module does not create a resource group, it is expecting the value of a resource group already exists"
  type        = string
}

variable "sku_name" {
  type        = string
  description = "The SKU of the APIM, should be seperated with an underslash for scale units, e.g. Premium_3"
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

variable "virtual_network_type" {
  type        = string
  description = "The virtual network type"
  default     = "None"
}

variable "zones" {
  type        = list(string)
  description = "The zones that the APIM is in"
  default     = []
}
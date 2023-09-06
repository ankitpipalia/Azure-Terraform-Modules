variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
  type        = string
}

variable "location" {
  description = "The location/region in which to create the storage account."
  type        = string
  default     = "West Europe"
}

variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account."
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account."
  type        = string
  default     = "GRS"
}

variable "tags" {
  description = "The tags to associate with your network and resources."
  type        = map(string)
  default     = {}
}

variable "storage_container_name" {
  description = "The name of the storage container within the storage account."
  type        = string
}

variable "container_access_type" {
  description = "Defines the access level used for this storage container."
  type        = string
  default     = "private"
}

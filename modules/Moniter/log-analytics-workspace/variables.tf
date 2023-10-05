variable "log_analytics_workspace_name" {
  description = "Name of the Log Analytics Workspace."
  type        = string
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

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region to use."
  type        = string
}

variable "allow_resource_only_permissions" {
  description = "Specifies if the log Analytics Workspace allow users accessing to data associated with resources they have permission to view, without permission to workspace. Defaults to true."
  type        = bool
  default     = true
}

variable "local_authentication_disabled" {
  description = "Specifies if the log Analytics workspace should enforce authentication using Azure AD. Defaults to false."
  type        = bool
  default     = true
}
variable "sku" {
  description = "Specifies the SKU of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018 (new SKU as of 2018-04-03). Defaults to PerGB2018."
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "The workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730."
  type        = number
  default     = 30
}

variable "daily_quota_gb" {
  description = "The workspace daily quota for ingestion in GB. Defaults to -1 (unlimited) if omitted."
  type        = number
  default     = null
}

variable "cmk_for_query_forced" {
  description = "Is Customer Managed Storage mandatory for query management?" ### Need to reviex this part
  type        = bool
  default     = false
}

variable "internet_ingestion_enabled" {
  description = "Should the Log Analytics Workspace support ingestion over the Public Internet?."
  type        = bool
  default     = true
}

variable "internet_query_enabled" { #### Need to undertsand impact
  description = "Should the Log Analytics Workspace support querying over the Public Internet?"
  type        = bool
  default     = true
}

variable "reservation_capacity_in_gb_per_day" {
  description = "The capacity reservation level in GB for this workspace. Must be in increments of 100 between 100 and 5000."
  type        = number
  default     = null
}

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

variable "application_insights_name" {
  description = "The name of the application insights resource."
  type        = string
}

variable "location" {
  description = "The location to deploy the resource to."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "application_type" {
  type        = string
  default     = "other"
  description = "Specifies the type of Application Insights to create. Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET. Please note these values are case sensitive; unmatched values are treated as ASP.NET by Azure. Changing this forces a new resource to be created. Default is other."
}

variable "daily_data_cap_in_gb" {
  type        = number
  default     = 100
  description = "Specifies the Application Insights component daily data volume cap in GB. Default is 100GB. Per Microsoft: \"Use care when you set the daily cap. Your intent should be to never hit the daily cap. If you hit the daily cap, you lose data for the remainder of the day, and you can't monitor your application.\""
}

variable "daily_data_cap_notifications_disabled" {
  type        = bool
  default     = false
  description = "Specifies if a notification email will be send when the daily data volume cap is met. Default is false. Notifications will be sent to the default roles set by Microsoft."
}

variable "retention_in_days" {
  type        = number
  default     = 90
  description = "Specifies the retention period in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730. Default is 90."
}

variable "sampling_percentage" {
  type        = number
  default     = 100
  description = "Specifies the percentage of the data produced by the monitored application that is sampled for Application Insights telemetry. Default is 100 percent."
}

variable "disable_ip_masking" {
  type        = bool
  default     = false
  description = "By default the real client ip is masked as 0.0.0.0 in the logs. Use this argument to disable masking and log the real client ip. Defaults to false."
}

variable "workspace_id" {
  description = "The Log Analytics workspace ID to send logs to."
  type        = string
  default     = null
}

variable "local_authentication_disabled" {
  description = "Should local auth be disabled?"
  type        = bool
  default     = false
}

variable "internet_ingestion_enabled" {
  description = "Is the internet ingestion endpoint enabled?"
  type        = bool
  default     = true
}

variable "internet_query_enabled" {
  description = "Is the internet query endpoint enabled?"
  type        = bool
  default     = true
}

variable "force_customer_storage_for_profiler" {
  description = "Should force customer storage for profiler be enabled?"
  type        = bool
  default     = false
} 

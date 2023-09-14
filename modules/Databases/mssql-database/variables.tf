variable "mssql_database_name" {
  type        = string
  description = "Name of MSSQL database"
}

variable "server_id" {
  type        = string
  description = "Id of SQL server"
}

variable "collation" {
  type        = string
  description = "Specifies the collation of the database"
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "sku" {
  type        = string
  description = "Specifies the SKU of the database"
}

variable "max_size" {
  type        = string
  description = "The max size of the database in gigabytes"
}

variable "min_capacity" {
  type        = string
  description = "The min size of the database in gigabytes"
}

variable "autopause_delay" {
  type        = number
  description = "Time in minutes after which database is automatically paused. A value of -1 means that automatic pause is disabled"
  default     = -1
}

variable "retention_days" {
  type        = number
  description = "Specifies the number of days to keep in the Threat Detection audit logs."
  default     = 3
}

variable "create_mode" {
  type        = string
  description = "Type of create mode selected in database config object"
  default     = "Default"
}

variable "creation_source_database_id" {
  type        = string
  description = "This variable is used in case 'create_mode'='Copy'"
  default     = null
}

variable "storage_account_type" {
  type        = string
  description = "Specifies the storage account type used to store backups for this database"
}

variable "databases" {
  type        = map(map(string))
  description = "Map of databases"
  default     = {}
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Log Analytics Workspace ID"
  default     = ""
}

variable "log_category_list" {
  type = list(any)
  default = [
    "QueryStoreRuntimeStatistics",
    "QueryStoreWaitStatistics",
    "Errors",
    "DatabaseWaitStatistics",
    "Timeouts",
    "Blocks",
    "Deadlocks"
  ]
  description = "Category list log"
}

variable "category_list_metrics" {
  type = list(any)
  default = [
    "Basic",
    "WorkloadManagement"
  ]
  description = "Category list metrics"
}

variable "log_retention_days" {
  default     = 7
  type        = number
  description = "Retention log policy days"
}

variable "metric_retention_days" {
  default     = 7
  type        = number
  description = "Retention metric policy days"
}

variable "destination_type" {
  type        = string
  default     = "Dedicated"
  description = "Log analytics destination type"
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
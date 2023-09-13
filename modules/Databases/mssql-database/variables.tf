variable "mssql_database_name" {
  type = string
  description = "Name of MSSQL database"
}

variable "location" {
  type        = string
  description = "Azure location"
}

variable "server_id" {
  type        = string
  description = "Id of SQL server"
}

variable "server_fqdn" {
  type        = string
  description = "FQDN of Azure SQL Server"
}

variable "default_collation" {
  type        = string
  description = "Specifies the collation of the database"
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "default_sku" {
  type        = string
  description = "Specifies the SKU of the database"
  default     = "GP_S_Gen5_1"
}

variable "default_max_size" {
  type        = string
  description = "The max size of the database in gigabytes"
  default     = "20"
}

variable "default_min_capacity" {
  type        = string
  description = "The min size of the database in gigabytes"
  default     = "0.5"
}

variable "default_autopause_delay" {
  type        = number
  description = "Time in minutes after which database is automatically paused. A value of -1 means that automatic pause is disabled"
  default     = 60
}

variable "default_retention_days" {
  type        = number
  description = "Specifies the number of days to keep in the Threat Detection audit logs."
  default     = 3
}

variable "default_create_mode" {
  type        = string
  description = "Type of create mode selected in database config object"
  default     = "Default"
}

variable "default_creation_source_database_id" {
  type        = string
  description = "This variable is used in case 'create_mode'='Copy'"
  default     = null
}

variable "storage_account_type" {
  type        = string
  description = "Specifies the storage account type used to store backups for this database"
  default     = "ZRS"
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
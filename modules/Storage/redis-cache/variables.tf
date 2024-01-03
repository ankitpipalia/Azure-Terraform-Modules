variable "location" {
  description = "Azure Region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
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

variable "cache_name" {
  description = "The name of the Redis cache instance"
  type        = string
}

variable "capacity" {
  description = "The size of the Redis cache to deploy"
  type        = number
}

variable "family" {
  description = "The family of the Redis cache to deploy"
  type        = string
}

variable "sku" {
  description = "The SKU of the Redis cache to deploy. Must be [Basic/Standard/Premium]"
  type        = string
}

variable "enable_non_ssl_port" {
  description = "Enable non-SSL port on Redis cache"
  type        = bool
  default = false
}

variable "minimum_tls_version" {
  description = "The minimum TLS version for the Redis cache"
  type        = string
  default = "1.0"
}

variable "cluster_shard_count" {
  description = "The number of shards for the Redis cache"
  type        = number
  default     = 0
}

variable "private_static_ip_address" {
  description = "The static IP address for the Redis cache"
  type        = string
  default = null
}

variable "subnet_id" {
  description = "The ID of the subnet in which the Redis cache is deployed"
  type        = string
  default = null
}

variable "public_network_access_enabled" {
  description = "Enable public network access for the Redis cache"
  type        = bool
  default = true
}

variable "redis_version" {
  description = "The version of Redis to deploy"
  type        = string
}

variable "zones" {
  description = "The availability zones in which to create the Redis cache"
  type        = list(string)
  default = []
}

variable "redis_configurations" {
  description = "A map of Redis configurations."
  type = map(object({
    aof_backup_enabled              = optional(bool)
    aof_storage_connection_string_0 = optional(string)
    aof_storage_connection_string_1 = optional(string)
    enable_authentication           = optional(bool)
    maxmemory_reserved              = optional(number)
    maxmemory_delta                 = optional(number)
    maxmemory_policy                = optional(string)
    maxfragmentationmemory_reserved = optional(number)
    rdb_backup_enabled              = optional(bool)
    rdb_backup_frequency            = optional(number)
    rdb_backup_max_snapshot_count   = optional(number)
    rdb_storage_connection_string   = optional(string)
  }))
  default = {}
}

variable "patch_schedule" {
  description = "A map of patch schedule settings for the Redis cache."
  type = map(object({
    day_of_week        = string
    start_hour_utc     = optional(number)
    maintenance_window = optional(string)
  }))
  default = {}
}

variable "redis_firewall_rule" {
  type        = map(object({
    name      = string
    count     = number
    start_ip  = string
    end_ip    = string
  }))
  description = "A map of firewall rules for the Redis cache."
  default = {}
}
output "redis_cache_instance_id" {
  description = "The Route ID of Redis Cache"
  value       = azurerm_redis_cache.redis-cache.id
}

output "hostname" {
  description = "The Hostname of the Redis Instance"
  value       = azurerm_redis_cache.redis-cache.hostname
}

output "primary_access_key" {
  description = "The Primary access key for the Redis Instance"
  value       = azurerm_redis_cache.redis-cache.primary_access_key
}

output "secondary_access_key" {
  description = "The Secondary Access Key for the Redis Instance"
  value       = azurerm_redis_cache.redis-cache.secondary_access_key
}

output "primary_connection_string" {
  description = "The primary connection string of the Redis Instance."
  value       = azurerm_redis_cache.redis-cache.primary_connection_string
}

output "secondary_connection_string" {
  description = "The secondary connection string of the Redis Instance."
  value       = azurerm_redis_cache.redis-cache.secondary_connection_string
}
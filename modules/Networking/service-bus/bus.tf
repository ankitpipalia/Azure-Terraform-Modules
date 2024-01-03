resource "azurerm_servicebus_namespace" "namespace" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.sku
  capacity                      = var.capacity
  zone_redundant                = var.sku == "premium" ? var.zone_redundant : false
  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )

  dynamic "identity" {
    for_each = try(var.identity.type, null) != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "customer_managed_key" {
    for_each = try(var.customer_managed_key.key_vault_key_id, null) != null ? [var.customer_managed_key] : []
    content {
      key_vault_key_id                  = customer_managed_key.value.key_vault_key_id
      identity_id                       = customer_managed_key.value.identity_id
      infrastructure_encryption_enabled = customer_managed_key.value.infrastructure_encryption_enabled
    }
  }

  dynamic "network_rule_set" {
    for_each = try(var.network_rule_set.default_action, null) != null ? [var.network_rule_set] : []
    content {
      default_action                 = network_rule_set.value.default_action
      public_network_access_enabled  = network_rule_set.value.public_network_access_enabled
      trusted_services_allowed       = network_rule_set.value.trusted_services_allowed
      ip_rules                       = network_rule_set.value.ip_rules

      dynamic "network_rules" {
        for_each = try(network_rule_set.value.network_rules, null) != null ? [network_rule_set.value.network_rules] : []
        content {
          subnet_id                              = network_rules.value.subnet_id
          ignore_missing_vnet_service_endpoint   = network_rules.value.ignore_missing_vnet_service_endpoint
        }
      }
    }
  }

  local_auth_enabled             = var.local_auth_enabled
  public_network_access_enabled  = var.public_network_access_enabled
  minimum_tls_version            = var.minimum_tls_version
}



resource "azurerm_servicebus_queue" "queue" {
  for_each = { for q in var.queues : q.name => q }

  name                              = each.value.name
  namespace_id                      = azurerm_servicebus_namespace.namespace.id
  lock_duration                     = each.value.lock_duration
  max_message_size_in_kilobytes     = each.value.max_message_size_in_kilobytes
  max_size_in_megabytes             = each.value.max_size_in_megabytes
  requires_duplicate_detection      = each.value.requires_duplicate_detection
  requires_session                  = each.value.requires_session
  default_message_ttl               = each.value.default_message_ttl
  dead_lettering_on_message_expiration = each.value.dead_lettering_on_message_expiration
  duplicate_detection_history_time_window = each.value.duplicate_detection_history_time_window
  max_delivery_count                = each.value.max_delivery_count
  status                            = each.value.status
  enable_batched_operations         = each.value.enable_batched_operations
  auto_delete_on_idle               = each.value.auto_delete_on_idle
  enable_partitioning               = each.value.enable_partitioning
  enable_express                    = each.value.enable_express
  forward_to                        = each.value.forward_to
  forward_dead_lettered_messages_to = each.value.forward_dead_lettered_messages_to
}

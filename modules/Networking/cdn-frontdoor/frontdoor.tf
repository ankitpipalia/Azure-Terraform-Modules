resource "azurerm_cdn_frontdoor_profile" "cdn_frontdoor_profile" {
  name                = var.profile_name
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name

  response_timeout_seconds = var.response_timeout_seconds

  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )
}

resource "azurerm_cdn_frontdoor_endpoint" "cdn_frontdoor_endpoint" {
  for_each = try({ for endpoint in var.endpoints : endpoint.name => endpoint }, {})

  name                     = each.value.custom_resource_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.cdn_frontdoor_profile.id

  enabled = each.value.enabled

  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )
}

resource "azurerm_cdn_frontdoor_custom_domain" "cdn_frontdoor_custom_domain" {
  for_each = try({ for custom_domain in var.custom_domains : custom_domain.name => custom_domain }, {})

  name                     = each.value.custom_resource_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.cdn_frontdoor_profile.id
  dns_zone_id              = each.value.dns_zone_id
  host_name                = each.value.host_name

  dynamic "tls" {
    for_each = each.value.tls == null ? [] : ["enabled"]
    content {
      certificate_type        = each.value.tls.certificate_type
      minimum_tls_version     = each.value.tls.minimum_tls_version
      cdn_frontdoor_secret_id = each.value.tls.cdn_frontdoor_secret_id
    }
  }
}

resource "azurerm_cdn_frontdoor_route" "cdn_frontdoor_route" {
  for_each = try({ for route in var.routes : route.name => route }, {})

  name    = each.value.custom_resource_name
  enabled = each.value.enabled

  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.cdn_frontdoor_endpoint[each.value.endpoint_name].id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_group[each.value.origin_group_name].id

  cdn_frontdoor_origin_ids = local.origins_names_per_route[each.value.name]

  forwarding_protocol = each.value.forwarding_protocol
  patterns_to_match   = each.value.patterns_to_match
  supported_protocols = each.value.supported_protocols

  dynamic "cache" {
    for_each = each.value.cache == null ? [] : ["enabled"]
    content {
      query_string_caching_behavior = each.value.cache.query_string_caching_behavior
      query_strings                 = each.value.cache.query_strings
      compression_enabled           = each.value.cache.compression_enabled
      content_types_to_compress     = each.value.cache.content_types_to_compress
    }
  }

  cdn_frontdoor_custom_domain_ids = try(local.custom_domains_per_route[each.key], [])
  cdn_frontdoor_origin_path       = each.value.origin_path
  cdn_frontdoor_rule_set_ids      = try(local.rule_sets_per_route[each.key], [])

  https_redirect_enabled = each.value.https_redirect_enabled
  link_to_default_domain = each.value.link_to_default_domain
}

############################################################################################
                                    #frontdoor-rules
############################################################################################


resource "azurerm_cdn_frontdoor_rule_set" "cdn_frontdoor_rule_set" {
  for_each = {
    for rule_set in var.rule_sets : rule_set.name => rule_set
  }

  name = each.value.custom_resource_name

  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.cdn_frontdoor_profile.id
}

resource "azurerm_cdn_frontdoor_rule" "cdn_frontdoor_rule" {
  for_each = {
    for rule in local.rules_per_rule_set : format("%s.%s", rule.rule_set_name, rule.name) => rule
  }

  name = each.value.custom_resource_name

  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.cdn_frontdoor_rule_set[each.value.rule_set_name].id

  order             = each.value.order
  behavior_on_match = each.value.behavior_on_match

  actions {
    dynamic "url_rewrite_action" {
      for_each = each.value.actions.url_rewrite_actions
      iterator = action
      content {
        source_pattern          = action.value.source_pattern
        destination             = action.value.destination
        preserve_unmatched_path = action.value.preserve_unmatched_path
      }
    }
    dynamic "url_redirect_action" {
      for_each = each.value.actions.url_redirect_actions
      iterator = action
      content {
        redirect_type        = action.value.redirect_type
        destination_hostname = action.value.destination_hostname
        redirect_protocol    = action.value.redirect_protocol
        destination_path     = action.value.destination_path
        query_string         = action.value.query_string
        destination_fragment = action.value.destination_fragment
      }
    }
    dynamic "route_configuration_override_action" {
      for_each = each.value.actions.route_configuration_override_actions
      iterator = action
      content {
        cache_duration                = action.value.cache_duration
        cdn_frontdoor_origin_group_id = action.value.cdn_frontdoor_origin_group_id
        forwarding_protocol           = action.value.forwarding_protocol
        query_string_caching_behavior = action.value.query_string_caching_behavior
        query_string_parameters       = action.value.query_string_parameters
        compression_enabled           = action.value.compression_enabled
        cache_behavior                = action.value.cache_behavior
      }
    }
    dynamic "request_header_action" {
      for_each = each.value.actions.request_header_actions
      iterator = action
      content {
        header_action = action.value.header_action
        header_name   = action.value.header_name
        value         = action.value.value
      }
    }
    dynamic "response_header_action" {
      for_each = each.value.actions.response_header_actions
      iterator = action
      content {
        header_action = action.value.header_action
        header_name   = action.value.header_name
        value         = action.value.value
      }
    }
  }

  dynamic "conditions" {
    for_each = each.value.conditions[*]
    content {
      dynamic "remote_address_condition" {
        for_each = each.value.conditions.remote_address_conditions
        iterator = condition
        content {
          operator         = condition.value.operator
          negate_condition = condition.value.negate_condition
          match_values     = condition.value.match_values
        }
      }
      dynamic "request_method_condition" {
        for_each = each.value.conditions.request_method_conditions
        iterator = condition
        content {
          match_values     = condition.value.match_values
          operator         = condition.value.operator
          negate_condition = condition.value.negate_condition
        }
      }
      dynamic "query_string_condition" {
        for_each = each.value.conditions.query_string_conditions
        iterator = condition
        content {
          operator         = condition.value.operator
          negate_condition = condition.value.negate_condition
          match_values     = condition.value.match_values
          transforms       = condition.value.transforms
        }
      }
      dynamic "post_args_condition" {
        for_each = each.value.conditions.post_args_conditions
        iterator = condition
        content {
          post_args_name   = condition.value.post_args_name
          operator         = condition.value.operator
          negate_condition = condition.value.negate_condition
          match_values     = condition.value.match_values
          transforms       = condition.value.transforms
        }
      }
      dynamic "request_uri_condition" {
        for_each = each.value.conditions.request_uri_conditions
        iterator = condition
        content {
          operator         = condition.value.operator
          negate_condition = condition.value.negate_condition
          match_values     = condition.value.match_values
          transforms       = condition.value.transforms
        }
      }
      dynamic "request_header_condition" {
        for_each = each.value.conditions.request_header_conditions
        iterator = condition
        content {
          header_name      = condition.value.header_name
          operator         = condition.value.operator
          negate_condition = condition.value.negate_condition
          match_values     = condition.value.match_values
          transforms       = condition.value.transforms
        }
      }
      dynamic "request_body_condition" {
        for_each = each.value.conditions.request_body_conditions
        iterator = condition
        content {
          operator         = condition.value.operator
          match_values     = condition.value.match_values
          negate_condition = condition.value.negate_condition
          transforms       = condition.value.transforms
        }
      }
      dynamic "request_scheme_condition" {
        for_each = each.value.conditions.request_scheme_conditions
        iterator = condition
        content {
          operator         = condition.value.operator
          negate_condition = condition.value.negate_condition
          match_values     = condition.value.match_values
        }
      }
      dynamic "url_path_condition" {
        for_each = each.value.conditions.url_path_conditions
        iterator = condition
        content {
          operator         = condition.value.operator
          negate_condition = condition.value.negate_condition
          match_values     = condition.value.match_values
          transforms       = condition.value.transforms
        }
      }
      dynamic "url_file_extension_condition" {
        for_each = each.value.conditions.url_file_extension_conditions
        iterator = condition
        content {
          operator         = condition.value.operator
          negate_condition = condition.value.negate_condition
          match_values     = condition.value.match_values
          transforms       = condition.value.transforms
        }
      }
      dynamic "url_filename_condition" {
        for_each = each.value.conditions.url_filename_conditions
        iterator = condition
        content {
          operator         = condition.value.operator
          match_values     = condition.value.match_values
          negate_condition = condition.value.negate_condition
          transforms       = condition.value.transforms
        }
      }
      dynamic "http_version_condition" {
        for_each = each.value.conditions.http_version_conditions
        iterator = condition
        content {
          match_values     = condition.value.match_values
          operator         = condition.value.operator
          negate_condition = condition.value.negate_condition
        }
      }
      dynamic "cookies_condition" {
        for_each = each.value.conditions.cookies_conditions
        iterator = condition
        content {
          cookie_name      = condition.value.cookie_name
          operator         = condition.value.operator
          negate_condition = condition.value.negate_condition
          match_values     = condition.value.match_values
          transforms       = condition.value.transforms
        }
      }
      dynamic "is_device_condition" {
        for_each = each.value.conditions.is_device_conditions
        iterator = condition
        content {
          operator         = condition.value.operator
          negate_condition = condition.value.negate_condition
          match_values     = condition.value.match_values
        }
      }
      dynamic "socket_address_condition" {
        for_each = each.value.conditions.socket_address_conditions
        iterator = condition
        content {
          operator         = condition.value.operator
          negate_condition = condition.value.negate_condition
          match_values     = condition.value.match_values
        }
      }
      dynamic "client_port_condition" {
        for_each = each.value.conditions.client_port_conditions
        iterator = condition
        content {
          operator         = condition.value.operator
          negate_condition = condition.value.negate_condition
          match_values     = condition.value.match_values
        }
      }
      dynamic "server_port_condition" {
        for_each = each.value.conditions.server_port_conditions
        iterator = condition
        content {
          operator         = condition.value.operator
          match_values     = condition.value.match_values
          negate_condition = condition.value.negate_condition
        }
      }
      dynamic "host_name_condition" {
        for_each = each.value.conditions.host_name_conditions
        iterator = condition
        content {
          operator     = condition.value.operator
          match_values = condition.value.match_values
          transforms   = condition.value.transforms
        }
      }
      dynamic "ssl_protocol_condition" {
        for_each = each.value.conditions.ssl_protocol_conditions
        iterator = condition
        content {
          match_values     = condition.value.match_values
          operator         = condition.value.operator
          negate_condition = condition.value.negate_condition
        }
      }
    }
  }

  depends_on = [
    azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_group,
    azurerm_cdn_frontdoor_origin.cdn_frontdoor_origin,
  ]
}


############################################################################################
                                    #frontdoor-policies
############################################################################################
resource "azurerm_cdn_frontdoor_firewall_policy" "cdn_frontdoor_firewall_policy" {
  for_each = try({ for firewall_policy in var.firewall_policies : firewall_policy.name => firewall_policy }, {})

  name                              = each.value.custom_resource_name
  resource_group_name               = var.resource_group_name
  sku_name                          = var.sku_name
  enabled                           = each.value.enabled
  mode                              = each.value.mode
  redirect_url                      = each.value.redirect_url
  custom_block_response_status_code = each.value.custom_block_response_status_code
  custom_block_response_body        = each.value.custom_block_response_body

  dynamic "custom_rule" {
    for_each = try(each.value.custom_rules, {})
    content {
      name                           = custom_rule.value.name
      enabled                        = custom_rule.value.enabled
      priority                       = custom_rule.value.priority
      rate_limit_duration_in_minutes = custom_rule.value.rate_limit_duration_in_minutes
      rate_limit_threshold           = custom_rule.value.rate_limit_threshold
      type                           = custom_rule.value.type
      action                         = custom_rule.value.action

      dynamic "match_condition" {
        for_each = try(custom_rule.value.match_conditions, {})
        content {
          match_variable     = match_condition.value.match_variable
          match_values       = match_condition.value.match_values
          operator           = match_condition.value.operator
          selector           = match_condition.value.selector
          negation_condition = match_condition.value.negate_condition
          transforms         = match_condition.value.transforms
        }
      }
    }
  }

  dynamic "managed_rule" {
    for_each = try(each.value.managed_rules, {})
    content {
      type    = managed_rule.value.type
      version = managed_rule.value.version
      action  = managed_rule.value.action
      dynamic "exclusion" {
        for_each = try(managed_rule.value.exclusions, {})
        content {
          match_variable = exclusion.value.match_variable
          operator       = exclusion.value.operator
          selector       = exclusion.value.selector
        }
      }
      dynamic "override" {
        for_each = try(managed_rule.value.overrides, {})
        content {
          rule_group_name = override.value.rule_group_name
          dynamic "exclusion" {
            for_each = try(override.value.exclusions, {})
            content {
              match_variable = exclusion.value.match_variable
              operator       = exclusion.value.operator
              selector       = exclusion.value.selector
            }
          }
          dynamic "rule" {
            for_each = try(override.value.rules, {})
            content {
              rule_id = rule.value.rule_id
              action  = rule.value.action
              enabled = rule.value.enabled
              dynamic "exclusion" {
                for_each = try(rule.value.exclusions, {})
                content {
                  match_variable = exclusion.value.match_variable
                  operator       = exclusion.value.operator
                  selector       = exclusion.value.selector
                }
              }
            }
          }
        }
      }
    }
  }

  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )
}

resource "azurerm_cdn_frontdoor_security_policy" "cdn_frontdoor_security_policy" {
  for_each = try({ for security_policy in var.security_policies : security_policy.name => security_policy }, {})

  name                     = each.value.custom_resource_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.cdn_frontdoor_profile.id

  security_policies {
    firewall {
      cdn_frontdoor_firewall_policy_id = azurerm_cdn_frontdoor_firewall_policy.cdn_frontdoor_firewall_policy[each.value.firewall_policy_name].id
      association {
        patterns_to_match = each.value.patterns_to_match
        dynamic "domain" {
          for_each = try(each.value.custom_domain_names, [])
          content {
            cdn_frontdoor_domain_id = azurerm_cdn_frontdoor_custom_domain.cdn_frontdoor_custom_domain[domain.value].id
          }
        }
        dynamic "domain" {
          for_each = try(each.value.endpoint_names, [])
          content {
            cdn_frontdoor_domain_id = azurerm_cdn_frontdoor_endpoint.cdn_frontdoor_endpoint[domain.value].id
          }
        }
      }
    }
  }
}



############################################################################################
                                    #frontdoor-origins
############################################################################################

resource "azurerm_cdn_frontdoor_origin_group" "cdn_frontdoor_origin_group" {
  for_each = try({ for origin_group in var.origin_groups : origin_group.name => origin_group }, {})

  name                     = each.value.custom_resource_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.cdn_frontdoor_profile.id

  session_affinity_enabled = each.value.session_affinity_enabled

  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = each.value.restore_traffic_time_to_healed_or_new_endpoint_in_minutes

  dynamic "health_probe" {
    for_each = each.value.health_probe == null ? [] : ["enabled"]
    content {
      interval_in_seconds = each.value.health_probe.interval_in_seconds
      path                = each.value.health_probe.path
      protocol            = each.value.health_probe.protocol
      request_type        = each.value.health_probe.request_type
    }
  }

  load_balancing {
    additional_latency_in_milliseconds = each.value.load_balancing.additional_latency_in_milliseconds
    sample_size                        = each.value.load_balancing.sample_size
    successful_samples_required        = each.value.load_balancing.successful_samples_required
  }
}

resource "azurerm_cdn_frontdoor_origin" "cdn_frontdoor_origin" {
  for_each = try({ for origin in var.origins : origin.name => origin }, {})

  name                          = each.value.custom_resource_name
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.cdn_frontdoor_origin_group[each.value.origin_group_name].id

  enabled                        = each.value.enabled
  certificate_name_check_enabled = each.value.certificate_name_check_enabled
  host_name                      = each.value.host_name
  http_port                      = each.value.http_port
  https_port                     = each.value.https_port
  origin_host_header             = each.value.origin_host_header
  priority                       = each.value.priority
  weight                         = each.value.weight

  dynamic "private_link" {
    for_each = each.value.private_link == null ? [] : ["enabled"]
    content {
      request_message        = each.value.private_link.request_message
      target_type            = each.value.private_link.target_type
      location               = each.value.private_link.location
      private_link_target_id = each.value.private_link.private_link_target_id
    }
  }
}
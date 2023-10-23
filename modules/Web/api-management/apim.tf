resource "azurerm_api_management" "apim" {
  location                      = var.location
  name                          = var.apim_name
  publisher_email               = var.publisher_email
  publisher_name                = var.publisher_name
  resource_group_name           = var.resource_group_name
  sku_name                      = var.sku_name
  client_certificate_enabled    = try(var.client_certificate_enabled, null)
  gateway_disabled              = lookup(var.apim_settings, "additional_location", {}) != {} ? var.gateway_disabled : null
  min_api_version               = try(var.min_api_version, null)
  zones                         = tolist(var.zones)
  notification_sender_email     = try(var.notification_sender_email, null)
  public_network_access_enabled = try(var.public_network_access_enabled, true)
  virtual_network_type          = try(var.virtual_network_type, "Internal", "None")

  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )


  dynamic "virtual_network_configuration" {
    for_each = lookup(var.apim_settings, "virtual_network_configuration", {}) != {} ? [1] : []
    content {
      subnet_id = lookup(var.apim_settings.virtual_network_configuration, "subnet_id", null)
    }
  }

  dynamic "additional_location" {
    for_each = lookup(var.apim_settings, "additional_location", {}) != {} ? [1] : []
    content {
      location             = lookup(var.apim_settings.additional_location, "location", var.location)
      capacity             = lookup(var.apim_settings.additional_location, "capacity", null)
      zones                = tolist(lookup(var.apim_settings.additional_location, "zones", null))
      public_ip_address_id = lookup(var.apim_settings.additional_location, "public_ip_address_id", null)
    }
  }

  dynamic "certificate" {
    for_each = lookup(var.apim_settings, "certificate", {}) != {} ? [1] : []
    content {
      encoded_certificate  = lookup(var.apim_settings.certificate, "encoded_certificate", null)
      store_name           = lookup(var.apim_settings.certificate, "store_name", null)
      certificate_password = lookup(var.apim_settings.certificate, "certificate_password", null)
    }
  }

  dynamic "delegation" {
    for_each = lookup(var.apim_settings, "delegation", {}) != {} ? [1] : []
    content {
      subscriptions_enabled     = lookup(var.apim_settings.delegation, "subscriptions_enabled", null)
      user_registration_enabled = lookup(var.apim_settings.delegation, "user_registration_enabled", null)
      url                       = lookup(var.apim_settings.delegation, "url", null)
      validation_key            = lookup(var.apim_settings.delegation, "validation_key", null)
    }
  }

  dynamic "hostname_configuration" {
    for_each = lookup(var.apim_settings, "hostname_configuration", {}) != {} ? [1] : []
    content {

      dynamic "management" {
        for_each = lookup(var.apim_settings.hostname_configuration, "management", {}) != {} ? [1] : []
        content {
          host_name                       = lookup(var.apim_settings.hostname_configuration.management, "host_name", null)
          key_vault_id                    = lookup(var.apim_settings.hostname_configuration.management, "key_vault_id", null)
          certificate                     = lookup(var.apim_settings.hostname_configuration.management, "certificate", null)
          certificate_password            = lookup(var.apim_settings.hostname_configuration.management, "certificate_password", null)
          negotiate_client_certificate    = lookup(var.apim_settings.hostname_configuration.management, "negotiate_client_certificate", null)
          ssl_keyvault_identity_client_id = lookup(var.apim_settings.hostname_configuration.management, "ssl_keyvault_identity_client_id", null)
        }
      }

      dynamic "developer_portal" {
        for_each = lookup(var.apim_settings.hostname_configuration, "developer_portal", {}) != {} ? [1] : []
        content {
          host_name                       = lookup(var.apim_settings.hostname_configuration.developer_portal, "host_name", null)
          key_vault_id                    = lookup(var.apim_settings.hostname_configuration.developer_portal, "key_vault_id", null)
          certificate                     = lookup(var.apim_settings.hostname_configuration.developer_portal, "certificate", null)
          certificate_password            = lookup(var.apim_settings.hostname_configuration.developer_portal, "certificate_password", null)
          negotiate_client_certificate    = lookup(var.apim_settings.hostname_configuration.developer_portal, "negotiate_client_certificate", null)
          ssl_keyvault_identity_client_id = lookup(var.apim_settings.hostname_configuration.developer_portal, "ssl_keyvault_identity_client_id", null)
        }
      }

      dynamic "scm" {
        for_each = lookup(var.apim_settings.hostname_configuration, "scm", {}) != {} ? [1] : []
        content {
          host_name                       = lookup(var.apim_settings.hostname_configuration.scm, "host_name", null)
          key_vault_id                    = lookup(var.apim_settings.hostname_configuration.scm, "key_vault_id", null)
          certificate                     = lookup(var.apim_settings.hostname_configuration.scm, "certificate", null)
          certificate_password            = lookup(var.apim_settings.hostname_configuration.scm, "certificate_password", null)
          negotiate_client_certificate    = lookup(var.apim_settings.hostname_configuration.scm, "negotiate_client_certificate", null)
          ssl_keyvault_identity_client_id = lookup(var.apim_settings.hostname_configuration.scm, "ssl_keyvault_identity_client_id", null)
        }
      }

      dynamic "proxy" {
        for_each = lookup(var.apim_settings.hostname_configuration, "proxy", {}) != {} ? [1] : []
        content {
          host_name                       = lookup(var.apim_settings.hostname_configuration.proxy, "host_name", null)
          key_vault_id                    = lookup(var.apim_settings.hostname_configuration.proxy, "key_vault_id", null)
          certificate                     = lookup(var.apim_settings.hostname_configuration.proxy, "certificate", null)
          certificate_password            = lookup(var.apim_settings.hostname_configuration.proxy, "certificate_password", null)
          negotiate_client_certificate    = lookup(var.apim_settings.hostname_configuration.proxy, "negotiate_client_certificate", null)
          ssl_keyvault_identity_client_id = lookup(var.apim_settings.hostname_configuration.proxy, "ssl_keyvault_identity_client_id", null)
        }
      }
    }
  }



  dynamic "protocols" {
    for_each = lookup(var.apim_settings, "protocols", {}) != {} ? [1] : []
    content {
      enable_http2 = lookup(var.apim_settings.protocols, "enable_http2", null)
    }
  }

  dynamic "security" {
    for_each = lookup(var.apim_settings, "security", {}) != {} ? [1] : []
    content {
      enable_backend_ssl30  = lookup(var.apim_settings.protocols, "enable_backend_ssl30", false)
      enable_backend_tls10  = lookup(var.apim_settings.protocols, "enable_backend_tls10", false)
      enable_backend_tls11  = lookup(var.apim_settings.protocols, "enable_backend_tls101", false)
      enable_frontend_ssl30 = lookup(var.apim_settings.protocols, "enable_frontend_ssl30", false)
      enable_frontend_tls10 = lookup(var.apim_settings.protocols, "enable_frontend_tls10", false)
      enable_frontend_tls11 = lookup(var.apim_settings.protocols, "enable_frontend_tls11", false)

      tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = lookup(var.apim_settings.protocols, "tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled", false)
      tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = lookup(var.apim_settings.protocols, "tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled", false)
      tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = lookup(var.apim_settings.protocols, "tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled", false)
      tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = lookup(var.apim_settings.protocols, "tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled", false)
      tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = lookup(var.apim_settings.protocols, "tls_rsa_with_aes128_gcm_sha256_ciphers_enabled", false)
      tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = lookup(var.apim_settings.protocols, "tls_rsa_with_aes128_cbc_sha_ciphers_enabled", false)
      tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = lookup(var.apim_settings.protocols, "tls_rsa_with_aes128_cbc_sha256_ciphers_enabled", false)
      tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = lookup(var.apim_settings.protocols, "tls_rsa_with_aes256_cbc_sha256_ciphers_enabled", false)
      tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = lookup(var.apim_settings.protocols, "tls_rsa_with_aes256_cbc_sha_ciphers_enabled", false)
      triple_des_ciphers_enabled                          = lookup(var.apim_settings.protocols, "triple_des_ciphers_enabled", false)
    }
  }

  dynamic "sign_in" {
    for_each = lookup(var.apim_settings, "sign_in", {}) != {} ? [1] : []
    content {
      enabled = lookup(var.apim_settings.sign_in, "enabled", false)
    }
  }

  dynamic "tenant_access" {
    for_each = lookup(var.apim_settings, "tenant_access", {}) != {} ? [1] : []
    content {
      enabled = lookup(var.apim_settings.tenant_access, "enabled", false)
    }
  }

  dynamic "sign_up" {
    for_each = lookup(var.apim_settings, "sign_up", {}) != {} ? [1] : []
    content {
      enabled = lookup(var.apim_settings.sign_up, "enabled", false)

      dynamic "terms_of_service" {
        for_each = lookup(var.apim_settings.sign_up, "terms_of_service", {}) != {} ? [1] : []
        content {
          enabled          = lookup(var.apim_settings.sign_up.terms_of_service, "enabled", false)
          consent_required = lookup(var.apim_settings.sign_up.terms_of_service, "consent_required", false)
          text             = lookup(var.apim_settings.sign_up.terms_of_service, "text", false)

        }
      }
    }
  }

  dynamic "identity" {
    for_each = length(var.identity_ids) == 0 && var.identity_type == "SystemAssigned" ? [var.identity_type] : []
    content {
      type = var.identity_type
    }
  }

  dynamic "identity" {
    for_each = length(var.identity_ids) == 0 && var.identity_type == "SystemAssigned, UserAssigned" ? [var.identity_type] : []
    content {
      type         = var.identity_type
      identity_ids = length(var.identity_ids) > 0 ? var.identity_ids : []
    }
  }

  dynamic "identity" {
    for_each = length(var.identity_ids) > 0 || var.identity_type == "UserAssigned" ? [var.identity_type] : []
    content {
      type         = var.identity_type
      identity_ids = length(var.identity_ids) > 0 ? var.identity_ids : []
    }
  }

  dynamic "policy" {
    for_each = lookup(var.apim_settings, "policy", {}) != {} ? [1] : []
    content {
      xml_content = lookup(var.apim_settings.policy, "xml_content", null)
      xml_link    = lookup(var.apim_settings.policy, "xml_link", null)
    }
  }

}

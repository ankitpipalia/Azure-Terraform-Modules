#################################################################
# GENERAL
#################################################################

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the Kubernetes Cluster."
}

variable "location" {
  type        = string
  description = "(Required) The location in which to create the Kubernetes Cluster."
}

#################################################################
# AZURE KUBERNETES SERVICE - IDENTITY
#################################################################

variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string), null)
  })
  description = "(Optional) Used to define an Identity for the Kubernetes Cluster."
  default     = null
}


variable "service_principal" {
  type = object({
    client_id     = string
    client_secret = string
  })
  description = "(Optional) Used to define a Service Principal for the Kubernetes Cluster."
  default     = null
}

#################################################################
# AZURE KUBERNETES SERVICE - CLUSTER
#################################################################

variable "name" {
  type        = string
  description = "(Required) The name of the Kubernetes Cluster."
}

variable "kubernetes_version" {
  type        = string
  description = "(Required) The Kubernetes version to use for this Kubernetes Cluster."
  default     = null
}

variable "default_node_pool" {
  type = object({
    name                                = string
    vm_size                             = string
    capacity_reservation_group_id       = optional(string, null)
    custom_ca_trust_enabled             = optional(bool, null)
    custom_ca_trust_certificates_base64 = optional(list(string), null)
    enable_host_encryption              = optional(bool, null)
    enable_node_public_ip               = optional(bool, null)

    kubelet_config = optional(object({
      allowed_unsafe_sysctls          = optional(list(string), null)
      container_log_max_line          = optional(number, null)
      container_log_max_size_mb       = optional(number, null)
      cpu_cfs_quota_enabled           = optional(bool, null)
      cpu_cfs_quota_period            = optional(string, null)
      cpu_manager_policy              = optional(string, null)
      image_gc_high_threshold_percent = optional(number, null)
      image_gc_high_threshold         = optional(string, null)
      image_gc_low_threshold          = optional(string, null)
      pod_max_pid                     = optional(number, null)
      topology_manager_policy         = optional(string, null)
    }), null)

    linux_os_config = optional(object({
      swap_file_size_mb = optional(number, null)
      sysctl_config = optional(object({
        fs_aio_max_nr                      = optional(number, null)
        fs_file_max                        = optional(number, null)
        fs_inotify_max_user_watches        = optional(number, null)
        fs_nr_open                         = optional(number, null)
        kernel_threads_max                 = optional(number, null)
        net_core_netdev_max_backlog        = optional(number, null)
        net_core_optmem_max                = optional(number, null)
        net_core_rmem_default              = optional(number, null)
        net_core_rmem_max                  = optional(number, null)
        net_core_somaxconn                 = optional(number, null)
        net_core_wmem_default              = optional(number, null)
        net_core_wmem_max                  = optional(number, null)
        net_ipv4_ip_local_port_range_max   = optional(number, null)
        net_ipv4_ip_local_port_range_min   = optional(number, null)
        net_ipv4_neigh_default_gc_thresh1  = optional(number, null)
        net_ipv4_neigh_default_gc_thresh2  = optional(number, null)
        net_ipv4_neigh_default_gc_thresh3  = optional(number, null)
        net_ipv4_tcp_fin_timeout           = optional(number, null)
        net_ipv4_tcp_keepalive_intvl       = optional(number, null)
        net_ipv4_tcp_keepalive_probes      = optional(number, null)
        net_ipv4_tcp_keepalive_time        = optional(number, null)
        net_ipv4_tcp_max_syn_backlog       = optional(number, null)
        net_ipv4_tcp_max_tw_buckets        = optional(number, null)
        net_ipv4_tcp_tw_reuse              = optional(number, null)
        net_netfilter_nf_conntrack_buckets = optional(number, null)
        net_netfilter_nf_conntrack_max     = optional(number, null)
        vm_max_map_count                   = optional(number, null)
        vm_swappiness                      = optional(number, null)
        vm_vfs_cache_pressure              = optional(number, null)
      }))
      transparent_huge_page_defrag  = optional(string, null)
      transparent_huge_page_enabled = optional(string, null)
    }), null)

    fips_enabled       = optional(bool, null)
    kubelet_disk_type  = optional(string, null)
    max_pods           = optional(number, null)
    message_of_the_day = optional(string, null)

    node_network_profile = optional(object({
      node_public_ip_tags = optional(map(string), null)
    }), null)

    node_public_ip_prefix_id     = optional(string, null)
    node_labels                  = optional(map(string), null)
    node_taints                  = optional(list(string), null)
    only_critical_addons_enabled = optional(bool, null)
    orchestrator_version         = optional(string, null)
    os_disk_size_gb              = optional(number, null)
    os_disk_type                 = optional(string, null)
    os_sku                       = optional(string, null)
    pod_subnet_id                = optional(string, null)
    proximity_placement_group_id = optional(string, null)
    scale_down_mode              = optional(string, null)
    temporary_name_for_rotation  = optional(string, null)
    type                         = optional(string, null)
    tags                         = optional(map(string), null)
    ultra_ssd_enabled            = optional(bool, null)

    upgrade_settings = optional(object({
      max_surge = optional(number, null)
    }), null)

    vnet_subnet_id   = optional(string, null)
    workload_runtime = optional(string, null)
    zones            = optional(list(string), null)
    max_count        = optional(number, null)
    min_count        = optional(number, null)
    node_count       = optional(number, null)
  })
  description = "(Required) A default_node_pool_name block."
}

variable "dns_prefix" {
  type        = string
  description = "(Optional) The DNS prefix to use for the Kubernetes Cluster."
  default     = null
}

variable "dns_prefix_private_cluster" {
  type        = string
  description = "(Optional) The DNS prefix to use for the Kubernetes Cluster private cluster."
  default     = null
}

variable "aci_connector_linux" {
  type = object({
    subnet_name = string
  })
  description = "(Optional) Used to define the ACI Connector Linux block."
  default     = null
}

variable "automatic_channel_upgrade" {
  type        = string
  description = "(Optional) Should automatic channel upgrade be enabled?"
  default     = null
}

variable "api_server_access_profile" {
  type = object({
    authorized_ip_ranges     = optional(set(string), null)
    subnet_id                = optional(string)
    vnet_integration_enabled = optional(bool, null)
  })
  description = "(Optional) A api_server_access_profile block."
  default     = null
}

variable "auto_scaler_profile" {
  type = object({
    balance_similar_node_groups      = optional(bool, false)
    expander                         = optional(string, null)
    max_graceful_termination_sec     = optional(number, null)
    max_node_provisioning_time       = optional(string, null)
    max_unready_nodes                = optional(number, null)
    max_unready_percentage           = optional(number, null)
    new_pod_scale_up_delay           = optional(string, null)
    scale_down_delay_after_add       = optional(string, null)
    scale_down_delay_after_delete    = optional(string, null)
    scale_down_delay_after_failure   = optional(string, null)
    scan_interval                    = optional(string, null)
    scale_down_unneeded              = optional(string, null)
    scale_down_unready               = optional(string, null)
    scale_down_utilization_threshold = optional(number, null)
    empty_bulk_delete_max            = optional(number, null)
    skip_nodes_with_local_storage    = optional(bool, true)
    skip_nodes_with_system_pods      = optional(bool, true)
  })
  description = "(Optional) A auto_scaler_profile block."
  default     = null
}

variable "azure_active_directory_role_based_access_control" {
  type = object({
    managed                = optional(bool, null)
    tenant_id              = optional(string, null)
    admin_group_object_ids = optional(list(string), null)
    azure_rbac_enabled     = optional(bool, null)
    client_app_id          = optional(string, null)
    server_app_id          = optional(string, null)
    server_app_secret      = optional(string, null)
  })
  description = "(Optional) A azure_active_directory_role_based_access_control block."
  default     = null
}

variable "azure_policy_enabled" {
  type        = bool
  description = "(Optional) Should Azure Policy be enabled?"
  default     = false
}

variable "confidential_computing" {
  type = object({
    sgx_quote_helper_enabled = bool
  })
  description = "(Optional) A confidential_computing block."
  default     = null
}

variable "disk_encryption_set_id" {
  type        = string
  description = "(Optional) The ID of the Disk Encryption Set to use for enabling encryption at rest."
  default     = null
}

variable "edge_zone" {
  type        = string
  description = "(Optional) The name of the Edge Zone to use for the Kubernetes Cluster."
  default     = null
}

variable "http_application_routing_enabled" {
  type        = bool
  description = "(Optional) Should HTTP application routing be enabled?"
  default     = false
}

variable "http_proxy_config" {
  type = object({
    http_proxy  = optional(string, null)
    https_proxy = optional(string, null)
    no_proxy    = optional(list(string), null)
    trusted_ca  = optional(string, null)
  })
  description = "(Optional) A http_proxy_config block."
  default     = null
}

variable "image_cleaner_enabled" {
  type        = bool
  description = "(Optional) Should image cleaner be enabled?"
  default     = false
}

variable "image_cleaner_interval_hours" {
  type        = number
  description = "(Optional) The interval in hours for the image cleaner to run."
  default     = 48
}

variable "ingress_application_gateway" {
  type = object({
    gateway_id   = optional(string, null)
    gateway_name = optional(string, null)
    subnet_id    = optional(string, null)
    subnet_cidr  = optional(string, null)
  })
  description = "(Optional) A ingress_application_gateway block."
  default     = null
}

variable "key_management_service" {
  type = object({
    key_vault_key_id         = string
    key_vault_network_access = optional(string, null)
  })
  description = "(Optional) A key_management_service block."
  default     = null
}

variable "key_vault_secrets_provider" {
  type = object({
    secret_rotation_enabled  = optional(bool, null)
    secret_rotation_interval = optional(string, null)
  })
  description = "(Optional) A key_vault_secrets_provider block."
  default     = null
}

variable "kubelet_identity" {
  type = object({
    client_id                 = optional(string, null)
    object_id                 = optional(string, null)
    user_assigned_identity_id = optional(string, null)
  })
  description = "(Optional) A kubelet_identity block."
  default     = null
}

variable "linux_profile" {
  type = object({
    admin_username = string
    ssh_key = object({
      key_data = string
    })
  })
  description = "(Optional) A linux_profile block."
  default     = null
}

variable "local_account_disabled" {
  type        = bool
  description = "(Optional) Should local account be disabled?"
  default     = false
}

variable "maintenance_window" {
  type = object({
    allowed = optional(list(object({
      day   = string
      hours = list(number)
    })), [])
    not_allowed = optional(list(object({
      end   = string
      start = string
    })), [])
  })
  description = "(Optional) A maintenance_window block."
  default     = null
}

#OK
variable "maintenance_window_auto_upgrade" {
  type = object({
    frequency   = string
    interval    = number
    duration    = number
    day_of_week = optional(string, null)
    week_index  = optional(string, null)
    start_time  = optional(string, null)
    utc_offset  = optional(number, null)
    start_date  = optional(string, null)

    not_allowed = optional(list(object({
      end   = string
      start = string
    })), [])
  })
  description = "(Optional) Configuration block for the maintenance window auto upgrade settings."
  default     = null
}

variable "maintenance_window_node_os" {
  type = object({
    frequency   = string
    interval    = number
    duration    = number
    day_of_week = optional(string, null)
    week_index  = optional(string, null)
    start_time  = optional(string, null)
    utc_offset  = optional(number, null)
    start_date  = optional(string, null)

    not_allowed = optional(list(object({
      end   = string
      start = string
    })), [])
  })
  description = "(Optional) A maintenance_window_node_os block."
  default     = null
}

variable "microsoft_defender" {
  type = object({
    log_analytics_workspace_id = string
  })
  description = "(Optional) Should Microsoft Defender be enabled?"
  default     = null
}

variable "monitor_metrics" {
  type = object({
    annotations_allowed = optional(string, null)
    labels_allowed      = optional(string, null)
  })
  description = "(Optional) Specifies a Prometheus add-on profile for the Kubernetes Cluster. A monitor_metrics block as defined below."
  default     = null
}

variable "network_profile" {
  type = object({
    network_plugin      = string
    network_mode        = optional(string, null)
    network_policy      = optional(string, null)
    dns_service_ip      = optional(string, null)
    ebpf_data_plane     = optional(string, null)
    network_plugin_mode = optional(string, null)
    outbound_type       = optional(string, null)
    pod_cidr            = optional(string, null)
    pod_cidrs           = optional(list(string), null)
    service_cidr        = optional(string, null)
    service_cidrs       = optional(list(string), null)
    ip_versions         = optional(list(string), null)
    load_balancer_sku   = optional(string, null)

    load_balancer_profile = optional(object({
      idle_timeout_in_minutes     = optional(number, null)
      managed_outbound_ip_count   = optional(number, null)
      managed_outbound_ipv6_count = optional(number, null)
      outbound_ip_address_ids     = optional(list(string), null)
      outbound_ip_prefix_ids      = optional(list(string), null)
      outbound_ports_allocated    = optional(number, null)
    }), null)

    nat_gateway_profile = optional(object({
      idle_timeout_in_minutes   = optional(number, null)
      managed_outbound_ip_count = optional(number, null)
    }), null)
  })
  description = "(Optional) A network_profile block."
  default     = null
}

variable "node_os_channel_upgrade" {
  type        = string
  description = "(Optional) The node OS channel upgrade to use for the Kubernetes Cluster."
  default     = null
}

variable "node_resource_group" {
  type        = string
  description = "(Optional) The name of the resource group containing the Kubernetes Cluster nodes."
  default     = null
}

variable "oidc_issuer_enabled" {
  type        = bool
  description = "(Optional) Should OIDC issuer be enabled?"
  default     = false
}

variable "oms_agent" {
  type = object({
    log_analytics_workspace_id = string
  })
  description = "(Optional) A oms_agent block."
  default     = null
}

variable "open_service_mesh_enabled" {
  type        = bool
  description = "(Optional) Should open service mesh be enabled?"
  default     = false
}

variable "private_cluster_enabled" {
  type        = bool
  description = "(Optional) Should private cluster be enabled?"
  default     = false
}

variable "private_dns_zone_id" {
  type        = string
  description = "(Optional) The ID of the Private DNS Zone to use for the Kubernetes Cluster."
  default     = null
}

variable "private_cluster_public_fqdn_enabled" {
  type        = bool
  description = "(Optional) Should private cluster public FQDN be enabled?"
  default     = false
}

variable "service_mesh_profile" {
  type = object({
    mode                             = string
    internal_ingress_gateway_enabled = optional(bool, null)
    external_ingress_gateway_enabled = optional(bool, null)
  })
  description = "(Optional) A service_mesh_profile block."
  default     = null
}

variable "workload_autoscaler_profile" {
  type = object({
    keda_enabled                    = optional(bool, null)
    vertical_pod_autoscaler_enabled = optional(bool, null)
  })
  description = "(Optional) A workload_autoscaler_profile block."
  default     = null
}

variable "workload_identity_enabled" {
  type        = bool
  description = "(Optional) Should workload identity be enabled?"
  default     = false
}

variable "role_based_access_control_enabled" {
  type        = bool
  description = "(Optional) Should role based access control be enabled?"
  default     = false
}

variable "run_command_enabled" {
  type        = bool
  description = "(Optional) Should run command be enabled?"
  default     = false
}

variable "sku_tier" {
  type        = string
  description = "(Optional) The SKU tier to use for this Kubernetes Cluster."
  default     = null
}

variable "storage_profile" {
  type = object({
    blob_driver_enabled         = optional(bool, null)
    disk_driver_enabled         = optional(bool, null)
    disk_driver_version         = optional(string, null)
    file_driver_enabled         = optional(bool, null)
    snapshot_controller_enabled = optional(bool, null)
  })
  description = "(Optional) A storage_profile block."
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

variable "web_app_routing" {
  type = object({
    dns_zone_id = string
  })
  description = "(Optional) A web_app_routing block."
  default     = null
}

variable "windows_profile" {
  type = object({
    admin_username = string
    admin_password = optional(string, null)
    license        = optional(string, null)

    gmsa = optional(object({
      dns_server  = optional(string, null)
      root_domain = optional(string, null)
    }), null)
  })
  description = "(Optional) A windows_profile block."
  default     = null
}

#################################################################
# AZURE KUBERNETES SERVICE - CLUSTER EXTENSIONS
#################################################################

variable "cluster_extentions" {
  type = list(object({
    name                             = string
    extension_type                   = string
    configuration_protected_settings = optional(map(string), null)
    configuration_settings           = optional(map(string), null)

    plan = optional(object({
      name           = string
      product        = string
      publisher      = string
      promotion_code = optional(string, null)
      version        = optional(string, null)
    }), null)

    release_train     = optional(string, null)
    release_namespace = optional(string, null)
    target_namespace  = optional(string, null)
    version           = optional(string, null)
  }))
  description = "(Optional) A cluster_extentions block."
  default     = []
}

#################################################################
# AZURE KUBERNETES SERVICE - DIAGNOSTIC
#################################################################

variable "diagnostic_settings" {
  type = object({
    name                           = string
    eventhub_name                  = optional(string, null)
    eventhub_authorization_rule_id = optional(string, null)
    log_analytics_workspace_id     = optional(string, null)
    storage_account_id             = optional(string, null)
    log_analytics_destination_type = optional(string, null)
    partner_solution_id            = optional(string, null)

    enabled_log = optional(object({
      category       = optional(string, null)
      category_group = optional(string, null)
    }), null)

    metrics = optional(object({
      category = optional(string, null)
      enabled  = optional(bool, null)
    }), null)
  })
  description = "(Optional) A diagnostic_settings block."
  default     = null
}
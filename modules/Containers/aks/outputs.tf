output "id" {
  value       = azurerm_kubernetes_cluster.this.id
  description = "The ID of the Kubernetes Cluster."
}

output "fqdn" {
  value       = azurerm_kubernetes_cluster.this.fqdn
  description = "The FQDN of the Azure Kubernetes Managed Cluster."
}

output "private_fqdn" {
  value       = azurerm_kubernetes_cluster.this.private_fqdn
  description = "The private FQDN of the Azure Kubernetes Managed Cluster."
}

output "portal_fqdn" {
  value       = azurerm_kubernetes_cluster.this.portal_fqdn
  description = "The portal FQDN of the Azure Kubernetes Managed Cluster."
}

#################################################################
# KUBE ADMIN CONFIG
#################################################################
output "kube_admin_config_client_key" {
  value       = try(azurerm_kubernetes_cluster.this.kube_admin_config[0].client_key, "")
  description = "The Kubernetes Admin Config Client Key for the Azure Kubernetes Managed Cluster."
}

output "kube_admin_config_client_certificate" {
  value       = try(azurerm_kubernetes_cluster.this.kube_admin_config[0].client_certificate, "")
  description = "The Kubernetes Admin Config Client Certificate for the Azure Kubernetes Managed Cluster."
}

output "kube_admin_config_cluster_ca_certificate" {
  value       = try(azurerm_kubernetes_cluster.this.kube_admin_config[0].cluster_ca_certificate, "")
  description = "The Kubernetes Admin Config Cluster CA Certificate for the Azure Kubernetes Managed Cluster."
}

output "kube_admin_config_host" {
  value       = try(azurerm_kubernetes_cluster.this.kube_admin_config[0].host, "")
  description = "The Kubernetes Admin Config Host for the Azure Kubernetes Managed Cluster."
}

output "kube_admin_config_password" {
  value       = try(azurerm_kubernetes_cluster.this.kube_admin_config[0].password, "")
  description = "The Kubernetes Admin Config Password for the Azure Kubernetes Managed Cluster."
}

output "kube_admin_config_raw" {
  value       = azurerm_kubernetes_cluster.this.kube_admin_config_raw
  description = "The Kubernetes Admin Config Raw for the Azure Kubernetes Managed Cluster."
}

#################################################################
# KUBE CONFIG
#################################################################

output "kube_config_client_key" {
  value       = try(azurerm_kubernetes_cluster.this.kube_config[0].client_key, "")
  description = "The Kubernetes Config Client Key for the Azure Kubernetes Managed Cluster."
}

output "kube_config_client_certificate" {
  value       = try(azurerm_kubernetes_cluster.this.kube_config[0].client_certificate, "")
  description = "The Kubernetes Config Client Certificate for the Azure Kubernetes Managed Cluster."
}

output "kube_config_cluster_ca_certificate" {
  value       = try(azurerm_kubernetes_cluster.this.kube_config[0].cluster_ca_certificate, "")
  description = "The Kubernetes Config Cluster CA Certificate for the Azure Kubernetes Managed Cluster."
}

output "kube_config_host" {
  value       = try(azurerm_kubernetes_cluster.this.kube_config[0].host, "")
  description = "The Kubernetes Config Host for the Azure Kubernetes Managed Cluster."
}

output "kube_config_password" {
  value       = try(azurerm_kubernetes_cluster.this.kube_config[0].password, "")
  description = "The Kubernetes Config Password for the Azure Kubernetes Managed Cluster."
}

output "kube_config_raw" {
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  description = "The Kubernetes Config Raw for the Azure Kubernetes Managed Cluster."
}

#################################################################
output "http_application_routing_zone_name" {
  value       = azurerm_kubernetes_cluster.this.http_application_routing_zone_name
  description = "The DNS Zone Name for the HTTP Application Routing Zone."
}

output "oidc_issuer_url" {
  value       = azurerm_kubernetes_cluster.this.oidc_issuer_url
  description = "The OIDC Issuer URL for the Azure Kubernetes Managed Cluster."
}

output "node_resource_group" {
  value       = azurerm_kubernetes_cluster.this.node_resource_group
  description = "The Node Resource Group for the Azure Kubernetes Managed Cluster."
}

output "node_resource_group_id" {
  value       = azurerm_kubernetes_cluster.this.node_resource_group_id
  description = "The Node Resource Group ID for the Azure Kubernetes Managed Cluster."
}

output "effective_outbound_ips" {
  value       = azurerm_kubernetes_cluster.this.network_profile[0].load_balancer_profile[0].effective_outbound_ips
  description = "The effective outbound IP resources for the Azure Kubernetes Managed Cluster."
}

#################################################################
# APPLICATION GATEWAY INGRESS
#################################################################
output "ingress_appgw_effective_gateway_id" {
  value       = try(azurerm_kubernetes_cluster.this.ingress_application_gateway[0].effective_gateway_id, null)
  description = "The effective gateway ID for the Azure Kubernetes Managed Cluster."
}

output "ingress_appgw_identity_client_id" {
  value       = try(azurerm_kubernetes_cluster.this.ingress_application_gateway[0].ingress_application_gateway_identity[0].client_id, null)
  description = "The client ID for the Azure Kubernetes Managed Cluster."
}

output "ingress_appgw_identity_object_id" {
  value       = try(azurerm_kubernetes_cluster.this.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id, null)
  description = "The object ID for the Azure Kubernetes Managed Cluster."
}

output "ingress_appgw_user_assigned_identity_id" {
  value       = try(azurerm_kubernetes_cluster.this.ingress_application_gateway[0].ingress_application_gateway_identity[0].user_assigned_identity_id, null)
  description = "The user assigned identity ID for the Azure Kubernetes Managed Cluster."
}

#################################################################
# OMG AGENT
#################################################################
output "oms_agent_identity_client_id" {
  value       = try(azurerm_kubernetes_cluster.this.oms_agent[0].oms_agent_identity[0].client_id, null)
  description = "The client ID for the Azure Kubernetes Managed Cluster."
}

output "oms_agent_identity_object_id" {
  value       = try(azurerm_kubernetes_cluster.this.oms_agent[0].oms_agent_identity[0].object_id, null)
  description = "The object ID for the Azure Kubernetes Managed Cluster."
}

output "oms_agent_user_assigned_identity_id" {
  value       = try(azurerm_kubernetes_cluster.this.oms_agent[0].oms_agent_identity[0].user_assigned_identity_id, null)
  description = "The user assigned identity ID for the Azure Kubernetes Managed Cluster."
}

#################################################################
# KEY VAULT SECRET PROVIDER
#################################################################
output "keyvault_secret_provider_client_id" {
  value       = try(azurerm_kubernetes_cluster.this.key_vault_secrets_provider[0].secret_identity[0].client_id, null)
  description = "The client ID for the Azure Kubernetes Managed Cluster."
}

output "keyvault_secret_provider_object_id" {
  value       = try(azurerm_kubernetes_cluster.this.key_vault_secrets_provider[0].secret_identity[0].object_id, null)
  description = "The object ID for the Azure Kubernetes Managed Cluster."
}


output "keyvault_secret_provider_user_assigned_identity_id" {
  value       = try(azurerm_kubernetes_cluster.this.key_vault_secrets_provider[0].secret_identity[0].user_assigned_identity_id, null)
  description = "The user assigned identity ID for the Azure Kubernetes Managed Cluster."
}

#################################################################
# ACI CONNECTOR LINUX
#################################################################
output "aci_connector_linux_identity_client_id" {
  value       = try(azurerm_kubernetes_cluster.this.aci_connector_linux[0].connector_identity[0].client_id, null)
  description = "The client ID for the Azure Kubernetes Managed Cluster."
}

output "aci_connector_linux_identity_object_id" {
  value       = try(azurerm_kubernetes_cluster.this.aci_connector_linux[0].connector_identity[0].object_id, null)
  description = "The object ID for the Azure Kubernetes Managed Cluster."
}

output "aci_connector_linux_identity_user_assigned_identity_id" {
  value       = try(azurerm_kubernetes_cluster.this.aci_connector_linux[0].connector_identity[0].user_assigned_identity_id, null)
  description = "The user assigned identity ID for the Azure Kubernetes Managed Cluster."
}

#################################################################
# IDENTITY
#################################################################
output "nodepool_identity_object_id" {
  value       = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
  description = "The object ID for the Azure Kubernetes Managed Cluster."
}

output "identity_principal_id" {
  value       = azurerm_user_assigned_identity.this[0].principal_id
  description = "Specifies the principal id of the managed identity of the AKS cluster."
}

output "identity_id" {
  value = azurerm_user_assigned_identity.this[0].id
  description = "Specifies the id of the managed identity of the AKS cluster."
}

output "identity_tenant_id" {
  value       = azurerm_user_assigned_identity.this[0].tenant_id
  description = "The tenant ID for the Azure Kubernetes Managed Cluster."
}

#################################################################
# WORKLOAD AUTOSCALER PROFILE
#################################################################
output "workload_autoscaler_profile_vertical_pod_autoscaler_controlled_values" {
  value       = try(azurerm_kubernetes_cluster.this.workload_autoscaler_profile[0].vertical_pod_autoscaler_controlled_values, null)
  description = "The controlled values for the Azure Kubernetes Managed Cluster."
}

output "workload_autoscaler_profile_vertical_pod_autoscaler_update_mode" {
  value       = try(azurerm_kubernetes_cluster.this.workload_autoscaler_profile[0].vertical_pod_autoscaler_update_mode, null)
  description = "The update mode for the Azure Kubernetes Managed Cluster."
}

#################################################################
# CLUSTER EXTENSIONS
#################################################################
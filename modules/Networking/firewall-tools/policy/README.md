# Azurerm_firewall_policy

Deploy an Azure Firewall Policy with the following features:

<!-- BEGIN_TF_DOCS -->
## Usage

# Azure Firewall Policy Example

```hcl
module "firewall-policy" {
  source              = "./modules/Networking/firewall-tools/policy"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  firewall_policy = {
    name                     = "example"
    sku                      = "Premium"
    private_ip_ranges        = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16", "100.64.0.0/10", "200.200.0.0/16"]
    threat_intelligence_mode = "Deny"
    threat_intelligence_allowlist = {
      ip_addresses = ["200.200.0.0/16"]
      fqdns        = ["example.com", "example.net"]
    }
  }

  tags       = local.tags
  extra_tags = local.extra_tags
}
```

## Inputs

| Name                             | Description                                                                      | Type    | Default | Required |
| -------------------------------- | -------------------------------------------------------------------------------- | ------- | ------- | --------- |
| `firewall_policy.name`           | The name of the Firewall Policy.                                                | `string` | n/a     | yes       |
| `location`                       | Specifies the supported Azure location where the resource exists.               | `string` | n/a     | yes       |
| `resource_group_name`            | The name of the resource group in which to create the resource.                 | `string` | n/a     | yes       |
| `firewall_policy.sku`            | The SKU configuration for the Firewall Policy.                                   | `object` | n/a     | yes       |
| `firewall_policy.base_policy_id` | The ID of the base Firewall Policy, if it exists.                                | `string` | `null`  | no        |
| `firewall_policy.threat_intelligence_mode` | The operation mode for threat intelligence-based filtering. Possible values are: "Off", "Alert", "Deny", and an empty string. | `string` | "Alert" | no |
| `firewall_policy.private_ip_ranges` | A list of SNAT private CIDR IP ranges, or the special string "IANAPrivateRanges", which indicates Azure Firewall does not SNAT when the destination IP address is a private range per IANA RFC 1918. | `list(string)` | `null` | no |
| `firewall_policy.auto_learn_private_ranges_enabled` | Should auto-learn private ranges be enabled? | `bool` | n/a | yes |
| `firewall_policy.sql_redirect_allowed` | Allow SQL traffic redirection? | `bool` | n/a | yes |
| `dns`                            | DNS configuration for the Firewall Policy.                                     | `object` | `null`  | no        |
| `tls_inspection`                 | TLS inspection configuration for the Firewall Policy.                            | `object` | `null`  | no        |
| `intrusion_detection`            | Intrusion Detection and Prevention System (IDPS) configuration for the Firewall Policy. | `object` | `null`  | no        |
| `explicit_proxy`                 | Explicit Proxy configuration for the Firewall Policy.                             | `object` | `null`  | no        |
| `insights`                       | Policy Analytics configuration for the Firewall Policy.                            | `object` | `null`  | no        |
| `tags`                           | Tags to be applied to resources (inclusive).                                      | `object` | `{}`    | no        |
| `extra_tags`                     | Extra tags to be applied to resources (in addition to the tags above).             | `map(string)` | `{}`    | no        |

### Threat Intelligence in Azure portal (Dynamic Block)

| Name                              | Description                                                                      | Type    | Default | Required |
| --------------------------------- | -------------------------------------------------------------------------------- | ------- | ------- | --------- |
| `threat_intelligence_allowlist`   | Threat intelligence allowlist configuration for the Firewall Policy.              | `object` | `null`  | no        |
| `threat_intelligence_allowlist.ip_addresses` | List of IP addresses to be allowed.                                | `list(string)` | `null` | no |
| `threat_intelligence_allowlist.fqdns` | List of FQDNs to be allowed.                                | `list(string)` | `null` | no |

### DNS in Azure portal (Dynamic Block)

| Name                 | Description                                                                      | Type    | Default | Required |
| -------------------- | -------------------------------------------------------------------------------- | ------- | ------- | --------- |
| `dns`                | DNS configuration for the Firewall Policy.                                       | `object` | `null`  | no        |
| `dns.servers`       | List of DNS servers.                                                            | `list(string)` | `null` | no |
| `dns.proxy_enabled` | Is DNS proxy enabled?                                                           | `bool` | `null` | no |

### TLS Inspection in Azure portal (Dynamic Block)

| Name                              | Description                                                                      | Type    | Default | Required |
| --------------------------------- | -------------------------------------------------------------------------------- | ------- | ------- | --------- |
| `tls_inspection`                  | TLS inspection configuration for the Firewall Policy.                            | `object` | `null`  | no        |
| `tls_inspection.tls_certificate`  | TLS certificate configuration for TLS inspection.                                  | `object` | `null`  | no        |
| `tls_inspection.tls_certificate.key_vault_secret_id` | The ID of the Key Vault secret containing the TLS certificate.     | `string` | `null`  | no |
| `tls_inspection.tls_certificate.name` | The name of the TLS certificate.                                  | `string` | `null`  | no |

### IDPS in Azure portal (Dynamic Block)

| Name                             | Description                                                                      | Type    | Default | Required |
| -------------------------------- | -------------------------------------------------------------------------------- | ------- | ------- | --------- |
| `intrusion_detection`            | Intrusion Detection and Prevention System (IDPS) configuration for the Firewall Policy. | `object` | `null`  | no        |
| `intrusion_detection.mode`       | The mode for intrusion detection. Possible values are: "Alert" or "Deny".         | `string` | `null`  | no        |
| `intrusion_detection.private_ranges` | List of private CIDR IP ranges.                                         | `list(string)` | `null` | no |
| `intrusion_detection.signature_overrides` | List of signature override configurations.                           | `list(object)` | `null` | no |
| `intrusion_detection.signature_overrides.id` | The ID of the signature override.                                  | `string` | `null` | no |
| `intrusion_detection.signature_overrides.state` | The state of the signature override. Possible values are: "Enabled" or "Disabled". | `string` | `null` | no |
| `intrusion_detection.traffic_bypass` | List of traffic bypass configurations.                           | `list(object)` | `null` | no |
| `intrusion_detection.traffic_bypass.name` | The name of the traffic bypass.                                      | `string` | `null` | no |
| `intrusion_detection.traffic_bypass.protocol` | The protocol for the traffic bypass.                               | `string` | `null` | no |
| `intrusion_detection.traffic_bypass.description` | The description of the traffic bypass.                            | `string` | `null` | no |
| `intrusion_detection.traffic_bypass.destination_addresses` | List of destination addresses for the traffic bypass.        | `list(string)` | `null` | no |
| `intrusion_detection.traffic_bypass.destination_ip_groups` | List of destination IP groups for the traffic bypass.        | `list(string)` | `null` | no |
| `intrusion_detection.traffic_bypass.destination_ports` | List of destination ports for the traffic bypass.            | `list(string)` | `null` | no |
| `intrusion_detection.traffic_bypass.source_addresses` | List of source addresses for the traffic bypass.              | `list(string)` | `null` | no |
| `intrusion_detection.traffic_bypass.source_ip_groups` | List of source IP groups for the traffic bypass.              | `list(string)` | `null` | no |

### Explicit Proxy in Azure portal (Dynamic Block)

| Name                         | Description                                                                      | Type    | Default | Required |
| ---------------------------- | -------------------------------------------------------------------------------- | ------- | ------- | --------- |
| `explicit_proxy`             | Explicit Proxy configuration for the Firewall Policy.                            | `object` | `null`  | no        |
| `explicit_proxy.enabled`     | Is explicit proxy enabled?                                                       | `bool` | `null`  | no        |
| `explicit_proxy.http_port`  | HTTP port for explicit proxy.                                                   | `number` | `null`  | no        |
| `explicit_proxy.https_port` | HTTPS port for explicit proxy.                                                  | `number` | `null`  | no        |
| `explicit_proxy.enable_pac_file` | Enable PAC file for explicit proxy?                                        | `bool` | `null`  | no        |
| `explicit_proxy.pac_file_port` | PAC file port for explicit proxy.                                            | `number` | `null`  | no        |
| `explicit_proxy.pac_file`    | PAC file for explicit proxy.                                                    | `string` | `null`  | no        |

### Policy Analytics in Azure portal (Dynamic Block)

| Name                            | Description                                                                      | Type    | Default | Required |
| ------------------------------- | -------------------------------------------------------------------------------- | ------- | ------- | --------- |
| `insights`                      | Policy Analytics configuration for the Firewall Policy.                            | `object` | `null`  | no        |
| `insights.enabled`              | Is Policy Analytics enabled?                                                     | `bool` | `null`  | no        |
| `insights.default_log_analytics_workspace_id` | The ID of the default Log Analytics workspace.                    | `string` | `null`  | no |
| `insights.retention_in_days`    | Retention in days for Policy Analytics data.                                     | `number` | `null`  | no |
| `insights.log_analytics_workspace` | Log Analytics workspace configuration for Policy Analytics.                   | `object` | `null`  | no        |
| `insights.log_analytics_workspace.workspace_id` | The ID of the Log Analytics workspace.                                  | `string` | `null`  | no |
| `insights.log_analytics_workspace.firewall_location` | The location of the firewall for Policy Analytics.               | `string` | `null`  | no |

## Outputs

| Name                    | Description                               | Value                                     |
| ----------------------- | ----------------------------------------- | ----------------------------------------- |
| `id`                    | Firewall policy ID                         | `azurerm_firewall_policy.default.id`      |
| `name`                  | Firewall policy name                       | `azurerm_firewall_policy.default.name`    |
| `associated_firewalls`  | Firewalls associated to this policy       | `azurerm_firewall_policy.default.firewalls` |
| `rule_collection_groups`| Existing rule collection groups            | `azurerm_firewall_policy.default.rule_collection_groups` |
<!-- END_TF_DOCS -->
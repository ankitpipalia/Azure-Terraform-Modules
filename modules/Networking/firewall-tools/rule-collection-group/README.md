# Azurerm_firewall_rule_collection_group

Deploy an Azure Firewall Rule Collection Group with Terraform using the [azurerm_firewall_rule_collection_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_rule_collection_group) resource.

<!-- BEGIN_TF_DOCS -->
## Usage

# Azure Firewall Policy Example

```hcl
module "rule-collection-group" {
  source = "./modules/Networking/firewall-tools/rule-collection-group"

  name = "test-rcg"
  firewall_policy_id = module.firewall-policy.id
  priority = 100

  network_rule_collections = {
    net-global-blacklist = {
      action   = "Deny"
      priority = 100
      rules = {
        unsecure1 = { source_addresses = [local.local_subnet], destination_addresses = ["100.100.100.100", "100.100.100.101"], protocols = ["Any"], destination_ports = ["*"] }
        unsecure2 = { source_addresses = [local.local_subnet], destination_addresses = ["200.200.200.200", "200.200.200.201"], protocols = ["Any"], destination_ports = ["*"] }
      }
    }
    net-global-default = {
      priority = 105
      rules = {
        ntp            = { source_addresses = [local.local_subnet], destination_addresses = ["pool.ntp.org"], protocols = ["UDP"], destination_ports = ["123"] }
        icmp           = { source_addresses = [local.local_subnet], destination_addresses = [local.local_subnet], protocols = ["ICMP"], destination_ports = ["*"] }
        authentication = { source_addresses = [local.local_subnet], destination_addresses = local.adds_servers, protocols = ["TCP", "UDP"], destination_ports = ["53", "88", "123", "135", "137", "138", "139", "389", "445", "464", "636", "3268", "3269", "49152-65535"] }
      }
    }
  }
  application_rule_collection = {
    app-global-blacklist = {
      action   = "Deny"
      priority = 130
      rules = {
        webcategories = { source_addresses = [local.local_subnet], web_categories = ["CriminalActivity"], protocols = [{}, { type = "Http", port = "80" }] }
      }
    }
    app-global-default = {
      priority = 135
      rules = {
        windowsupdate = { source_addresses = [local.local_subnet], destination_fqdn_tags = ["WindowsUpdate"], protocols = [{}] }
      }
    }
  }
}

module "firewall-policy-messaging-rules" {
  source             = "./modules/Networking/firewall-tools/rule-collection-group"
  name               = "messaging-rules"
  firewall_policy_id = module.firewall-policy.id
  priority           = 200
  nat_rule_collection = {
    nat-messaging = {
      priority = 100
      rules = {
        smtp-prd = { source_addresses = ["*"], destination_address = "150.150.150.150", destination_port = 25, translated_address = "10.0.0.10", translated_port = 25 }
        smtp-uat = { source_addresses = ["*"], destination_address = "150.150.150.151", destination_port = 25, translated_address = "10.1.0.10", translated_port = 25 }
      }
    }
  }
}
```

## Inputs

| Name                          | Description                                                          | Type     | Default | Required |
|-------------------------------|----------------------------------------------------------------------|----------|---------|----------|
| `name`                        | Base name for the firewall policy rule collection group              | `string` | None    | Yes      |
| `firewall_policy_id`          | The ID of the Firewall Policy which this Rule Collection Group is associated with | `string` | None    | Yes      |
| `priority`                    | The priority of the rule collection group.                           | `number` | None    | Yes      |
| `network_rule_collections`    | The set of network rule collections to be created                    | `map`    | None    | No       |
| `nat_rule_collection`         | The set of NAT rule collections to be created                        | `map`    | None    | No       |
| `application_rule_collection` | The set of application rule collections to be created                | `map`    | None    | No       |

## Outputs

| Name                   | Description                                 |
|------------------------|---------------------------------------------|
| `collection_group_id`  | The ID of the created rule collection group |
| `collection_group_name`| The name of the created rule collection group|
<!-- END_TF_DOCS -->
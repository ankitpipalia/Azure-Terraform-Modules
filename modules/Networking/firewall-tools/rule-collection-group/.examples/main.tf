module "resource_group" {
  source = "./modules/Management/resource-group"

  resource_group_name = "test-rg"
  location            = "centralindia"
  tags                = local.tags
  extra_tags          = local.extra_tags
}

module "virtual_network" {
  source = "./modules/Networking/virtual-network"

  virtual_network_name = "test-vnet"
  location             = module.resource_group.location
  resource_group_name  = module.resource_group.name
  address_space        = ["10.0.0.0/16"]
  tags                 = local.tags
  extra_tags           = local.extra_tags
}

module "subnets" {
  source = "./modules/Networking/subnets"

  for_each              = toset(local.subnets)
  subnet_name           = each.value
  resource_group_name   = module.resource_group.name
  virtual_network_name  = module.virtual_network.name
  subnet_address_prefix = cidrsubnet(module.virtual_network.address_space[0], 8, index(local.subnets, each.value)) # Ensure unique address for each subnet
  # For example, if you're given a prefix ending in /16 and you want your subnets to have a prefix of /20, then newbits would be 4, because 20 - 16 = 4
}

module "public_ip_address" {
  source = "./modules/Networking/public-ip"

  public_ip_name      = "test-pip"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.tags
  extra_tags          = local.extra_tags
}

module "firewall" {
  source = "./modules/Networking/firewall-tools/firewall"

  firewall_name       = "test-fw"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  sku_name = "AZFW_VNet"
  sku_tier = "Standard"

  use_management_ip_configuration = true

  ip_configuration = [
    {
      name                 = "test-ip-config"
      subnet_id            = module.subnets["subnet1"].id
      public_ip_address_id = module.public_ip_address.id
    }
  ]

  tags       = local.tags
  extra_tags = local.extra_tags
}

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

module "rule-collection-group" {
  source = "./modules/Networking/firewall-tools/rule-collection-group"

  name               = "test-rcg"
  firewall_policy_id = module.firewall-policy.id
  priority           = 100

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
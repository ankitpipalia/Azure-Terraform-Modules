terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm" 
      version = "~>3.0" 
    }
  }
}

provider "azurerm" {
  features {} 
}

locals {
  subnets = ["subnet1", "subnet2", "subnet3"]
  tags = {
    environment = "Production"
    project     = "Project1"
  }
  custom_tags = {
    owner = "user1"
  }
  storage_account_name = "ankitstgsimform924"
  #storage_account_name_validation = length(local.storage_account_name) >= 3 && length(local.storage_account_name) <= 24 && can(regex("^[a-z0-9]*$", local.storage_account_name))
}

module "resource_group" {
  source = "./modules/Management/resource-group"

  resource_group_name = "test-rg"
  location = "centralindia"
  tags = local.tags
  custom_tags = local.custom_tags
}

module "storage_acount" {
  source = "./modules/Storage/storage-account"
  #storage_account_name = local.storage_account_name_validation ? local.storage_account_name : assert(false, "Invalid storage account name. The name can only consist of lowercase letters and numbers, and must be between 3 and 24 characters long.")
  storage_account_name = local.storage_account_name
  resource_group_name = module.resource_group.name
  location = module.resource_group.location
  account_tier = "Standard"
  replication_type = "LRS"

  default_network_rule = "Allow" # Allow or Deny All Public Access Not Recommanded Use Your Public IP using Access List

  access_list = {
    "ip1" = "150.129.104.117" # List Of IP's can access the storage account
  }

  
  static_website_enabled = true
  index_path = "index.html"
  custom_404_path = "error.html"

  containers = [
    {
      name = "images"
      access_type = "private"
    },
    {
      name = "thumbnails"
      access_type = "private"
    }
  ]


  tags = local.tags
  custom_tags = local.custom_tags
}
# module "virtual_network" {
#   source = "./modules/Networking/Virtual Networks"

#   virtual_network_name = "test-vnet"
#   location = module.resource_group.location
#   resource_group_name = module.resource_group.name
#   address_space = ["10.0.0.0/16"]
#   tags = local.tags
#   custom_tags = local.custom_tags
# }

# module "subnets" {
#   source = "./modules/Networking/subnets"

#   for_each = toset(local.subnets)
#   subnet_name = each.value
#   resource_group_name = module.resource_group.name
#   virtual_network_name = module.virtual_network.name
#   subnet_address_prefix = cidrsubnet(module.virtual_network.address_space[0], 8, index(local.subnets, each.value))  # Ensure unique address for each subnet
#   # For example, if you're given a prefix ending in /16 and you want your subnets to have a prefix of /20, then newbits would be 4, because 20 - 16 = 4
# }

# module "public_ip_address" {
#   source = "./modules/Networking/public-ip"

#   public_ip_name = "test-pip"
#   resource_group_name = module.resource_group.name
#   location = module.resource_group.location
#   allocation_method = "Static"
#   sku = "Standard"
#   tags = local.tags
#   custom_tags = local.custom_tags
# }

# module "network_interface" {
#   source = "./modules/Networking/network-interface"

#   network_interface_name = "test-nic"
#   resource_group_name = module.resource_group.name
#   location = module.resource_group.location
#   ip_configuration_name = "testconfiguration1"
#   subnet_id = module.subnets["subnet1"].id
#   private_ip_address_allocation = "Dynamic"
#   private_ip_address = null
#   public_ip_address_id = module.public_ip_address.id
#   tags = local.tags
#   custom_tags = local.custom_tags
# }

# module "network_security_group" {
#   source = "./modules/Networking/network-security-group"

#   network_security_group_name = "test-nsg"
#   resource_group_name = module.resource_group.name
#   location = module.resource_group.location
#   inbound_rules = [
#     {
#       name                       = "SSH"
#       priority                   = 100
#       access                     = "Allow"
#       protocol                   = "Tcp"
#       source_address_prefix      = "*"
#       source_port_range          = "*"
#       destination_address_prefix = "*"
#       destination_port_range     = "22"
#       description                = "Allow SSH"
#     }
#   ]
#   outbound_rules = [
#     {
#       name                       = "AllowInternetOutBound"
#       priority                   = 100
#       access                     = "Allow"
#       protocol                   = "*"
#       source_address_prefix      = "*"
#       source_port_range          = "*"
#       destination_address_prefix = "*"
#       destination_port_range     = "*"
#       description                = "Allow Internet OutBound"
#     }
#   ]
#   subnet_id = module.subnets["subnet1"].id  

#   tags = local.tags
#   custom_tags = local.custom_tags
# }

# module "virtual_machine" {
#   source = "./modules/Compute/virtual-machine"

#   virtual_machine_name = "test-vm"
#   resource_group_name = module.resource_group.name
#   location = module.resource_group.location
#   vm_size = "Standard_B1ls"
#   admin_username = "testadmin"
#   admin_password = "Password1234!"
#   network_interface_id = module.network_interface.id
#   source_image_publisher = "Canonical"
#   source_image_offer     = "0001-com-ubuntu-minimal-focal"
#   source_image_sku       = "minimal-20_04-lts-gen2"
#   source_image_version   = "latest"
#   depends_on = [ module.network_interface ]

#   tags = local.tags
#   custom_tags = local.custom_tags
# }
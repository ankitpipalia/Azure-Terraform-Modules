terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm" 
      version = ">3" 
    }
  }
}

provider "azurerm" {
  features {} 
}

locals {
  subnets = ["subnet1", "subnet2", "subnet3"]
}

module "resource_group" {
  source = "./resource-group"

  resource_group_name = "test-rg"
  location = "centralindia"
}

module "virtual_network" {
  source = "./virtual-network"

  virtual_network_name = "test-vnet"
  location = module.resource_group.location
  resource_group_name = module.resource_group.name
  address_space = ["10.0.0.0/16"]
}

module "subnets" {
  source = "./subnets"

  for_each = toset(local.subnets)
  subnet_name = each.value
  resource_group_name = module.resource_group.name
  virtual_network_name = module.virtual_network.name
  subnet_address_prefix = cidrsubnet(module.virtual_network.address_space[0], 8, index(local.subnets, each.value))  # Ensure unique address for each subnet
  # For example, if you're given a prefix ending in /16 and you want your subnets to have a prefix of /20, then newbits would be 4, because 20 - 16 = 4
}

module "public_ip_address" {
  source = "./public-ip"

  public_ip_name = "test-pip"
  resource_group_name = module.resource_group.name
  location = module.resource_group.location
  allocation_method = "Static"
  sku = "Standard"
}

module "network_interface" {
  source = "./network-interface"

  network_interface_name = "test-nic"
  resource_group_name = module.resource_group.name
  location = module.resource_group.location
  ip_configuration_name = "testconfiguration1"
  subnet_id = module.subnets["subnet1"].id
  private_ip_address_allocation = "Dynamic"
  private_ip_address = null
  public_ip_address_id = module.public_ip_address.id
}

module "network_security_group" {
  source = "./network-security-group"

  network_security_group_name = "test-nsg"
  resource_group_name = module.resource_group.name
  location = module.resource_group.location
  inbound_rules = [
    {
      name                       = "SSH"
      priority                   = 100
      access                     = "Allow"
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
      destination_address_prefix = "*"
      destination_port_range     = "22"
      description                = "Allow SSH"
    },
    {
      name                       = "HTTP"
      priority                   = 101
      access                     = "Allow"
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
      destination_address_prefix = "*"
      destination_port_range     = "80"
      description                = "Allow HTTP"
    },
    {
      name                       = "HTTPS"
      priority                   = 102
      access                     = "Allow"
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
      destination_address_prefix = "*"
      destination_port_range     = "443"
      description                = "Allow HTTPS"
    }
  ]
  outbound_rules = [
    {
      name                       = "AllowInternetOutBound"
      priority                   = 100
      access                     = "Allow"
      protocol                   = "*"
      source_address_prefix      = "*"
      source_port_range          = "*"
      destination_address_prefix = "*"
      destination_port_range     = "*"
      description                = "Allow Internet OutBound"
    }
  ]
  subnet_id = module.subnets["subnet1"].id  
}

module "virtual_machine" {
  source = "./virtual-machine"
  virtual_machine_name = "test-vm"
  resource_group_name = module.resource_group.name
  location = module.resource_group.location
  vm_size = "Standard_B1ls"
  admin_username = "testadmin"
  admin_password = "Password1234!"
  network_interface_id = module.network_interface.id
  source_image_publisher = "Canonical"
  source_image_offer     = "0001-com-ubuntu-minimal-focal"
  source_image_sku       = "minimal-20_04-lts-gen2"
  source_image_version   = "latest"
  depends_on = [ module.network_interface ]
}
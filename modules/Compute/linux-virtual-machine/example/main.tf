terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  required_version = "~>1.0"
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
  extra_tags = {
    owner = "user1"
  }
}

module "resource_group" {
  source = "~/git/Azure-Terraform-Modules/modules/Management/resource-group"

  resource_group_name = "test-rg"
  location            = "centralindia"
  tags                = local.tags
  extra_tags          = local.extra_tags
}

module "virtual_network" {
  source = "~/git/Azure-Terraform-Modules/modules/Networking/virtual-network"

  virtual_network_name = "test-vnet"
  location             = module.resource_group.location
  resource_group_name  = module.resource_group.name
  address_space        = ["10.0.0.0/16"]
  tags                 = local.tags
  extra_tags           = local.extra_tags
}

module "subnets" {
  source = "~/git/Azure-Terraform-Modules/modules/Networking/subnets"

  for_each              = toset(local.subnets)
  subnet_name           = each.value
  resource_group_name   = module.resource_group.name
  virtual_network_name  = module.virtual_network.name
  subnet_address_prefix = cidrsubnet(module.virtual_network.address_space[0], 8, index(local.subnets, each.value)) # Ensure unique address for each subnet
  # For example, if you're given a prefix ending in /16 and you want your subnets to have a prefix of /20, then newbits would be 4, because 20 - 16 = 4
}

module "public_ip_address" {
  source = "~/git/Azure-Terraform-Modules/modules/Networking/public-ip"

  public_ip_name      = "test-pip"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.tags
  extra_tags          = local.extra_tags
}

module "network_interface" {
  source = "~/git/Azure-Terraform-Modules/modules/Networking/network-interface"

  network_interface_name        = "test-nic"
  resource_group_name           = module.resource_group.name
  location                      = module.resource_group.location
  ip_configuration_name         = "testconfiguration1"
  subnet_id                     = module.subnets["subnet1"].id
  private_ip_address_allocation = "Dynamic"
  private_ip_address            = "10.0.0.4"
  #  public_ip_address_id = module.public_ip_address.id
  public_ip_address_id = null
  tags                 = local.tags
  extra_tags           = local.extra_tags
}

module "network_security_group" {
  source = "~/git/Azure-Terraform-Modules/modules/Networking/network-security-group"

  network_security_group_name = "test-nsg"
  resource_group_name         = module.resource_group.name
  location                    = module.resource_group.location
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

  tags       = local.tags
  extra_tags = local.extra_tags
}

module "nat_gateway" {
  source = "~/git/Azure-Terraform-Modules/modules/Networking/nat-gateway"

  nat_gateway_name     = "test-nat-gateway"
  resource_group_name  = module.resource_group.name
  location             = module.resource_group.location
  public_ip_address_id = module.public_ip_address.id
  subnet_id            = module.subnets["subnet1"].id
  tags                 = local.tags
  extra_tags           = local.extra_tags
}

module "virtual_machine" {
  source = "~/git/Azure-Terraform-Modules/modules/Compute/linux-virtual-machine"

  virtual_machine_name   = "test-vm"
  resource_group_name    = module.resource_group.name
  location               = module.resource_group.location
  vm_size                = "Standard_B1ls"
  admin_username         = "testadmin"
  admin_password         = "Password1234!"
  network_interface_id   = module.network_interface.id
  source_image_publisher = "Canonical"
  source_image_offer     = "0001-com-ubuntu-minimal-focal"
  source_image_sku       = "minimal-20_04-lts-gen2"
  source_image_version   = "latest"
  depends_on             = [module.network_interface]

  tags       = local.tags
  extra_tags = local.extra_tags
}
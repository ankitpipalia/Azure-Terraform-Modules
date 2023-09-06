locals {
  # App service IP Address, Subnet_ids and Service_Tag restrictions
  ip_address = [for ip_address in var.ips_allowed : {
    name                      = "ip_restriction_cidr_${join("", [1, index(var.ips_allowed, ip_address)])}"
    ip_address                = ip_address
    virtual_network_subnet_id = null
    service_tag               = null
    subnet_id                 = null
    priority                  = join("", [1, index(var.ips_allowed, ip_address)])
    action                    = "Allow"
  }]

  subnets = [for subnet in var.subnet_ids_allowed : {
    name                      = "ip_restriction_subnet_${join("", [1, index(var.subnet_ids_allowed, subnet)])}"
    ip_address                = null
    virtual_network_subnet_id = subnet
    service_tag               = null
    subnet_id                 = subnet
    priority                  = join("", [1, index(var.subnet_ids_allowed, subnet)])
    action                    = "Allow"
  }]

  service_tags = [for service_tag in var.service_tags_allowed : {
    name                      = "service_tag_restriction_${join("", [1, index(var.service_tags_allowed, service_tag)])}"
    ip_address                = null
    virtual_network_subnet_id = null
    service_tag               = service_tag
    subnet_id                 = null
    priority                  = join("", [1, index(var.service_tags_allowed, service_tag)])
    action                    = "Allow"
  }]
}
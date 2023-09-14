# Azure Load Balance Module 

A Terraform module which creates Load Balancer on Azure with the following characteristics:
- Ability to decide if it is a **Public** or **Private** Load Balancer
- Configure Security Group for HTTP access
- Create an Availabity Set if a load balancer is configured (True by Default)
- Add VMs in the Backend Address Pool of the Load Balancer

## Usage

# Public Load Balancer Creation example:

```hcl
module "lb" {
  source = "~/git/Azure-Terraform-Modules/modules/Networking/load-balancer"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  lb_name            = "test-lb"
  lb_type            = "public"
  ft_name            = "lb-web-server"
  lb_probes_port     = "80"
  lb_probes_protocol = "Tcp"
  lb_probes_path     = "/"
  lb_nb_probes       = "2"
  lb_rule_proto      = "Tcp"
  lb_rule_ft_port    = "80"
  lb_rule_bck_port   = "80"
  public_ip_id       = module.public_ip_address.id

  subnet_id = module.subnets["subnet1"].id

  tags                 = local.tags
  extra_tags           = local.extra_tags
}
```

# Private Load Balancer Creation example:

```hcl
module "lb" {
  source = "~/git/Azure-Terraform-Modules/modules/Networking/load-balancer"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  lb_name            = "test-lb"
  lb_type            = "private"
  ft_name            = "lb-web-server"
  lb_probes_port     = "80"
  lb_probes_protocol = "Tcp"
  lb_probes_path     = "/"
  lb_nb_probes       = "2"
  lb_rule_proto      = "Tcp"
  lb_rule_ft_port    = "80"
  lb_rule_bck_port   = "80"
  ft_priv_ip_addr   = "10.0.0.9"

  subnet_id = module.subnets["subnet1"].id

  tags                 = local.tags
  extra_tags           = local.extra_tags
}
```
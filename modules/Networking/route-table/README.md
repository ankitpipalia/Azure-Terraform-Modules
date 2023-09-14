# Azure Route Table - Terraform Module
This Terraform module creates an Azure Route Table.

# Azure Route Table example:

```hcl
module "route_table" {
  source = "./modules/Networking/route-table"

  name                  = "test-rt"
  resource_group_name   = module.resource_group.name
  location              = module.resource_group.location
  routes                = [
    {
      name                   = "route1"
      address_prefix         = "10.0.0.0/24"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.0.1.0"
    },
  ]
  disable_bgp_route_propagation = true
  subnet_id = module.subnets["subnet1"].id

  tags                  = local.tags
  extra_tags            = local.extra_tags
}
```

## Inputs

| Name                           | Description                                                           | Type     | Default | Required |
|--------------------------------|-----------------------------------------------------------------------|----------|---------|:--------:|
| `disable_bgp_route_propagation` | Boolean flag that controls propagation of routes learned by BGP on the route table. | bool     | true    | no       |
| `extra_tags`                   | Extra tags to be applied to resources in addition to the tags above.  | map(string) | {}      | no       |
| `location`                     | The location/region where the route table is created.                | string   | -       | yes      |
| `name`                         | The name of the route table.                                         | string   | -       | yes      |
| `resource_group_name`          | The name of the resource group in which to create the route table.    | string   | -       | yes      |
| `routes`                       | List of objects that represent the configuration of each route.      | list(map(string)) | []   | no       |
|                                | Each route object should have the following attributes:              |          |         |          |
|                                | - `name`: Name of the route.                                        |          |         |          |
|                                | - `address_prefix`: Address prefix for the route.                    |          |         |          |
|                                | - `next_hop_type`: Type of next hop for the route.                   |          |         |          |
|                                | - `next_hop_in_ip_address`: Next hop IP address (if applicable).     |          |         |          |
| `subnet_id`                    | The ID of the Subnet to associate with the Route Table.               | string   | -       | yes      |
| `tags`                         | Tags to be applied to resources (inclusive).                         | object   | -       | yes      |
|                                | - `environment`: Environment tag                                    | string   | -       | yes      |
|                                | - `project`: Project tag                                            | string   | -       | yes      |

## Outputs

| Name                  | Description                                                        |
| --------------------- | ------------------------------------------------------------------ |
| id                    | The route table configuration ID.                                  |
| name                  | The name of the route table.                                       |
| resource\_group\_name | The name of the resource group in which to create the route table. |
| location              | The location/region where the route table is created.              |
| routes                | Blocks containing configuration of each route.                     |
| subnets               | List of the ids of the subnets configured to the route table.      |
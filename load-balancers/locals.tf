locals {
  # Decide how the backend machines access internet. If outbound rules are defined use them instead of the default route.
  # This is an inbound rule setting, applicable to all inbound rules as you cannot mix SNAT with Outbound rules for a single backend.
  disable_outbound_snat = anytrue([for _, v in var.frontend_ips : try(length(v.out_rules) > 0, false)])

  # Calculate inbound rules
  in_flat_rules = flatten([
    for fipkey, fip in var.frontend_ips : [
      for rulekey, rule in try(fip.in_rules, {}) : {
        fipkey  = fipkey
        fip     = fip
        rulekey = rulekey
        rule    = rule
      }
    ]
  ])
  in_rules = { for v in local.in_flat_rules : "${v.fipkey}-${v.rulekey}" => v }

  # Calculate outbound rules
  out_flat_rules = flatten([
    for fipkey, fip in var.frontend_ips : [
      for rulekey, rule in try(fip.out_rules, {}) : {
        fipkey  = fipkey
        fip     = fip
        rulekey = rulekey
        rule    = rule
      }
    ]
  ])
  out_rules = { for v in local.out_flat_rules : "${v.fipkey}-${v.rulekey}" => v }
}
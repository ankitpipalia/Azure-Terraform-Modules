# Include all settings from the parent terragrunt.hcl files
include {
  path = find_in_parent_folders()
}

locals {
  env_vars     = read_terragrunt_config(find_in_parent_folders("env_vars.hcl"))
  project_vars = read_terragrunt_config(find_in_parent_folders("project_vars.hcl"))
}

terraform {
  source = "${get_parent_terragrunt_dir()}/modules/frontdoor" # Corrected path
}

dependency "rg" {
  config_path                             = "../resource-group"
  mock_outputs_allowed_terraform_commands = ["init", "state", "destroy"]
  mock_outputs = {
    worker_security_group_id = "mock"
  }
}

# Input variables specific to the dev environment, PACe tenant, and eastus region
inputs = {
  profile_name = "pacs-dev-fd"
  resource_group_name = dependency.rg.outputs.name
  location            = dependency.rg.outputs.location
  sku_name     = "Standard_AzureFrontDoor"

  endpoints = [
    {
      name                 = "web"
      custom_resource_name = "web"
    }
  ]

  custom_domains = [
    {
      name = "pacs"
      host_name = "pacs.com"
      custom_resource_name = "pacs"
    }
  ]

  origin_groups = [
    {
      name                 = "pacs"
      custom_resource_name = "pacs"
      health_probe = {
        interval_in_seconds = 250
        path                = "/"
        protocol            = "Https"
        request_type        = "GET"
      }
      load_balancing = {
        successful_samples_required = 1
      }
    }
  ]

  origins = [
    {
      name                           = "web"
      custom_resource_name           = "web"
      origin_group_name              = "pacs"
      certificate_name_check_enabled = false
      host_name                      = "www.pacs.com"
    }
  ]

  rule_sets = [
    {
      name                 = "my_rule_set"
      custom_resource_name = "customrule1"
    }
  ]

  routes = [
    {
      name                 = "route66"
      custom_resource_name = "route66"
      endpoint_name        = "web"
      origin_group_name    = "pacs"
      origins_names        = ["web"]
      forwarding_protocol  = "HttpsOnly"
      patterns_to_match    = ["/*"]
      supported_protocols  = ["Http", "Https"]
      rule_sets_names      = ["my_rule_set"]
    }
  ]

  firewall_policies = [{
    name                              = "test"
    custom_resource_name              = "test"
    enabled                           = true
    mode                              = "Prevention"
    redirect_url                      = "https://www.pacs.com"
    custom_block_response_status_code = 403
    custom_block_response_body        = "PGh0bWw+CjxoZWFkZXI+PHRpdGxlPkhlbGxvPC90aXRsZT48L2hlYWRlcj4KPGJvZHk+CkhlbGxvIHdvcmxkCjwvYm9keT4KPC9odG1sPg=="

    custom_rules = [
      {
        name                           = "Rule1"
        custom_resource_name           = "Rule1"
        enabled                        = true
        priority                       = 1
        rate_limit_duration_in_minutes = 1
        rate_limit_threshold           = 10
        type                           = "MatchRule"
        action                         = "Block"
        match_conditions = [{
          match_variable     = "RemoteAddr"
          operator           = "IPMatch"
          negation_condition = false
          match_values       = ["10.0.1.0/24", "10.0.0.0/24"]
        }]
      },
      {
        name                           = "Rule2"
        custom_resource_name           = "Rule2"
        enabled                        = true
        priority                       = 2
        rate_limit_duration_in_minutes = 1
        rate_limit_threshold           = 10
        type                           = "MatchRule"
        action                         = "Block"
        match_conditions = [
          {
            match_variable     = "RemoteAddr"
            operator           = "IPMatch"
            negation_condition = false
            match_values       = ["192.168.1.0/24"]
          },
          {
            match_variable     = "RequestHeader"
            selector           = "UserAgent"
            operator           = "Contains"
            negation_condition = false
            match_values       = ["windows"]
            transforms         = ["Lowercase", "Trim"]
          }
        ]
      }
    ]

    # managed_rules = [
    #   {
    #     type    = "DefaultRuleSet"
    #     version = "1.0"
    #     action  = "Log"
    #     exclusions = [{
    #       match_variable = "QueryStringArgNames"
    #       operator       = "Equals"
    #       selector       = "not_suspicious"
    #     }]
    #     overrides = [
    #       {
    #         rule_group_name = "PHP"
    #         rules = [{
    #           rule_id = "933100"
    #           enabled = false
    #           action  = "Block"
    #         }]
    #       },
    #       {
    #         rule_group_name = "SQLI"
    #         exclusions = [{
    #           match_variable = "QueryStringArgNames"
    #           operator       = "Equals"
    #           selector       = "really_not_suspicious"
    #         }]
    #         rules = [{
    #           rule_id = "942200"
    #           action  = "Block"
    #           exclusions = [{
    #             match_variable = "QueryStringArgNames"
    #             operator       = "Equals"
    #             selector       = "innocent"
    #           }]
    #         }]
    #       },
    #     ]
    #   },
    #   {
    #     type    = "Microsoft_BotManagerRuleSet"
    #     version = "1.0"
    #     action  = "Log"
    #   }
    # ]
  }]

  security_policies = [{
    name                 = "MySecurityPolicy"
    custom_resource_name = "MySecurityPolicy"
    custom_resource_name = "MyBetterNamedSecurityPolicy"
    firewall_policy_name = "test"
    patterns_to_match    = ["/*"]
    custom_domain_names  = ["pacs"]
    endpoint_names       = ["web"]
  }]

  environment = local.env_vars.locals.environment
  project     = local.project_vars.locals.project

  tags = {
    environment = local.env_vars.locals.environment
    project     = local.project_vars.locals.project
  }
  extra_tags = {
    CreatedBy = "Terragrunt"
  }
}
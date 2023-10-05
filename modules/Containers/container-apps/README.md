## Azure Terraform Module for Container Apps

This module creates a container app in Azure.

## Usage
```hcl
module "container-apps" {
  source = "./modules/Containers/container-apps"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  container_app_environment_name = "test-container-apps-env"
  tags                = local.tags
  extra_tags          = local.extra_tags

  container_apps = {
    test-container-apps = {
      name = "test-container-apps"
      revision_mode = "Single"

      template = {
        max_replicas    = 1
        min_replicas    = 1
        revision_suffix = "test"

        containers = [
          {
            name   = "test-container"
            image  = "nginx"
            cpu    = 1.0
            memory = "2Gi"
          }
        ]
      }
      ingress = {
        target_port = 80
        allow_insecure_connections = true
        external_enabled = true
        transport = "auto"
        traffic_weight = {
          label = "test"
          latest_revision = "true"
          revision_suffix = "test"
          percentage = 100
        }
      }
    }
  }
}
```

## Inputs

| Name                               | Description                                            | Type     | Default  | Required |
|------------------------------------|--------------------------------------------------------|----------|----------|:--------:|
| `location`                         | The Azure region where the resources should be created | string   | n/a      | yes      |
| `log_analytics_workspace_id`       | The ID of the Log Analytics workspace                  | string   | n/a      | yes      |
| `container_app_environment_name`   | The name of the container app environment              | string   | n/a      | yes      |
| `resource_group_name`              | The name of the resource group                         | string   | n/a      | yes      |
| `container_app_environment_infrastructure_subnet_id` | The ID of the infrastructure subnet for the container app environment | string | n/a | yes |
| `container_app_environment_internal_load_balancer_enabled` | Boolean flag to enable internal load balancer for the container app environment | bool | n/a | yes |
| `tags`                             | Tags to be applied to resources (inclusive)            | object   |          | no       |
| `extra_tags`                       | Extra tags to be applied to resources (in addition to the tags above) | map(string) | {} | no |
| `container_apps`                   | Configuration for container apps, see below            | map(object) | {}     | no       |
| `container_app_secrets`            | Secrets for container apps, see below                  | map(list(object)) | {} | no |

### Container Apps Configuration (`container_apps`)

| Name                   | Description                                        | Type   | Default | Required |
|------------------------|----------------------------------------------------|--------|---------|:--------:|
| `name`                 | The name of the container app                      | string | n/a     | yes      |
| `revision_mode`        | The revision mode for the container app (e.g., Always) | string | n/a     | yes      |
| `template`             | Container app template configuration, see below    | object | n/a     | yes      |
| `dapr`                 | Dapr configuration, see below                      | object | n/a     | no       |
| `identity`             | Identity configuration, see below                  | object | n/a     | no       |
| `ingress`              | Ingress configuration, see below                   | object | n/a     | no       |
| `registry`             | Registry configuration, see below                  | list(object) | [] | no    |

#### Container App Template Configuration (`template`)

| Name                   | Description                                        | Type   | Default | Required |
|------------------------|----------------------------------------------------|--------|---------|:--------:|
| `max_replicas`         | Maximum number of replicas                         | number | n/a     | yes      |
| `min_replicas`         | Minimum number of replicas                         | number | n/a     | yes      |
| `revision_suffix`      | Revision suffix for the container app              | string | n/a     | yes      |
| `containers`           | Container configuration, see below                  | list(object) | [] | no     |
| `volume`               | Volume configuration, see below                     | list(object) | [] | no     |

##### Container Configuration (`containers`)

| Name                   | Description                                        | Type   | Default | Required |
|------------------------|----------------------------------------------------|--------|---------|:--------:|
| `cpu`                  | CPU configuration for the container                | string | n/a     | yes      |
| `image`                | Container image URI                                | string | n/a     | yes      |
| `memory`               | Memory configuration for the container             | string | n/a     | yes      |
| `name`                 | Container name                                     | string | n/a     | yes      |
| `args`                 | Arguments for the container                        | list(string) | [] | no     |
| `command`              | Command to run inside the container                | list(string) | [] | no     |
| `env`                  | Environment variables for the container, see below | list(object) | [] | no     |
| `liveness_probe`       | Liveness probe configuration, see below             | object | n/a     | no     |
| `readiness_probe`      | Readiness probe configuration, see below            | object | n/a     | no     |
| `startup_probe`        | Startup probe configuration, see below              | object | n/a     | no     |
| `volume_mounts`        | Volume mounts for the container, see below          | list(object) | [] | no     |

###### Environment Variables (`env`)

| Name                   | Description                                        | Type   | Default | Required |
|------------------------|----------------------------------------------------|--------|---------|:--------:|
| `name`                 | Environment variable name                          | string | n/a     | yes      |
| `secret_name`          | Secret name (if the value is a secret)             | string | null    | no       |
| `value`                | Environment variable value                         | string | n/a     | no       |

###### Liveness Probe Configuration (`liveness_probe`)

| Name                   | Description                                        | Type   | Default | Required |
|------------------------|----------------------------------------------------|--------|---------|:--------:|
| `port`                 | Port to probe                                      | number | n/a     | yes      |
| `transport`            | Transport protocol (e.g., HTTP)                   | string | n/a     | yes      |
| `failure_count_threshold` | Failure count threshold                        | number | n/a     | yes      |
| `host`                 | Host to probe (optional)                           | string | null    | no       |
| `initial_delay`        | Initial delay before the probe starts (in seconds)| number | n/a     | yes      |
| `interval_seconds`     | Probe interval (in seconds)                       | number | n/a     | yes      |
| `path`                 | Probe path (if applicable)                        | string | null    | no       |
| `timeout`              | Probe timeout (in seconds)                        | number | n/a     | yes      |
| `header`               | HTTP header configuration, see below               | object | n/a     | no       |

###### HTTP Header Configuration (`header`)

| Name                   | Description                                        | Type   | Default | Required |
|------------------------|----------------------------------------------------|--------|---------|:--------:|
| `name`                 | Header name                                        | string | n/a     | yes      |
| `value`                | Header value                                       | string | n/a     | yes      |

###### Readiness Probe Configuration (`readiness_probe`)

| Name                   | Description                                        | Type   | Default | Required |
|------------------------|----------------------------------------------------|--------|---------|:--------:|
| `port`                 | Port to probe                                      | number | n/a     | yes      |
| `transport`            | Transport protocol (e.g., HTTP)                   | string | n/a     | yes      |
| `failure_count_threshold` | Failure count threshold                        | number | n/a     | yes      |
| `host`                 | Host to probe (optional)                           | string | null    | no       |
| `interval_seconds`     | Probe interval (in seconds)                       | number | n/a     | yes      |
| `path`                 | Probe path (if applicable)                        | string | null    | no       |
| `success_count_threshold` | Success count threshold                      | number | n/a     | yes      |
| `timeout`              | Probe timeout (in seconds)                        | number | n/a     | yes      |
| `header`               | HTTP header configuration, see below               | object | n/a     | no       |

###### Startup Probe Configuration (`startup_probe`)

| Name                   | Description                                        | Type   | Default | Required |
|------------------------|----------------------------------------------------|--------|---------|:--------:|
| `port`                 | Port to probe                                      | number | n/a     | yes      |
| `transport`            | Transport protocol (e.g., HTTP)                   | string | n/a     | yes      |
| `failure_count_threshold` | Failure count threshold                        | number | n/a     | yes      |
| `host`                 | Host to probe (optional)                           | string | null    | no       |
| `interval_seconds`     | Probe interval (in seconds)                       | number | n/a     | yes      |
| `path`                 | Probe path (if applicable)                        | string | null    | no       |
| `timeout`              | Probe timeout (in seconds)                        | number | n/a     | yes      |
| `header`               | HTTP header configuration, see below               | object | n/a     | no       |

###### Volume Mounts Configuration (`volume_mounts`)

| Name                   | Description                                        | Type   | Default | Required |
|------------------------|----------------------------------------------------|--------|---------|:--------:|
| `name`                 | Volume name                                        | string | n/a     | yes      |
| `path`                 | Volume mount path                                  | string | n/a     | yes      |

##### Volume Configuration (`volume`)

| Name                   | Description                                        | Type   | Default | Required |
|------------------------|----------------------------------------------------|--------|---------|:--------:|
| `name`                 | Volume name                                        | string | n/a     | yes      |
| `storage_name`         | Storage name (if applicable)                       | string | null    | no       |
| `storage_type`         | Storage type (if applicable)                       | string | null    | no       |

#### Dapr Configuration (`dapr`)

| Name                   | Description                                        | Type   | Default | Required |
|------------------------|----------------------------------------------------|--------|---------|:--------:|
| `app_id`               | Dapr app ID                                        | string | n/a     | yes      |
| `app_port`             | Dapr app port                                      | number | n/a     | yes      |
| `app_protocol`         | Dapr app protocol (e.g., HTTP)                    | string | n/a     | yes      |

#### Identity Configuration (`identity`)

| Name                   | Description                                        | Type   | Default | Required |
|------------------------|----------------------------------------------------|--------|---------|:--------:|
| `type`                 | Identity type (e.g., SystemAssigned)               | string | n/a     | yes      |
| `identity_ids`         | List of identity IDs                               | list(string) | [] | no   |

#### Ingress Configuration (`ingress`)

| Name                   | Description                                        | Type   | Default | Required |
|------------------------|----------------------------------------------------|--------|---------|:--------:|
| `target_port`          | Target port for ingress                            | number | n/a     | yes      |
| `allow_insecure_connections` | Allow insecure connections                 | bool   | n/a     | yes      |
| `external_enabled`     | Enable external access to the app                  | bool   | n/a     | yes      |
| `transport`            | Transport protocol (e.g., HTTP)                   | string | n/a     | yes      |
| `traffic_weight`       | Traffic weight configuration, see below             | object | n/a     | no       |

###### Traffic Weight Configuration (`traffic_weight`)

| Name                   | Description                                        | Type   | Default | Required |
|------------------------|----------------------------------------------------|--------|---------|:--------:|
| `percentage`           | Traffic percentage (0-100)                        | number | n/a     | yes      |
| `label`                | Traffic label (e.g., "label-1")                   | string | n/a     | yes      |
| `latest_revision`      | Latest revision flag (true/false)                  | bool   | n/a     | yes      |
| `revision_suffix`      | Revision suffix (e.g., "v1")                      | string | n/a     | yes      |

#### Registry Configuration (`registry`)

| Name                   | Description                                        | Type   | Default | Required |
|------------------------|----------------------------------------------------|--------|---------|:--------:|
| `server`               | Container registry server                          | string | n/a     | yes      |
| `identity`             | Registry identity configuration, see below         | object | n/a     | no       |
| `password_secret_name` | Secret name for the registry password (if applicable) | string | null  | no     |
| `username`             | Registry username                                  | string | n/a     | yes      |

###### Registry Identity Configuration (`identity`)

| Name                   | Description                                        | Type   | Default | Required |
|------------------------|----------------------------------------------------|--------|---------|:--------:|
| `type`                 | Identity type (e.g., SystemAssigned)               | string | n/a     | yes      |
| `identity_ids`         | List of identity IDs                               | list(string) | [] | no   |

## Outputs

| Name                             | Description                                        |
|----------------------------------|----------------------------------------------------|
| `container_app_environment_id`   | The ID of the Container App Environment within which this Container App should exist. |
| `container_app_fqdn`             | The FQDN of the Container App's ingress. If multiple container apps exist, it provides a map of container names to their respective FQDNs. |
| `container_app_ips`              | The IPs of the Latest Revision of the Container App. |


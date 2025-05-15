# Terraform AWS ECS ![](https://img.shields.io/github/actions/workflow/status/wearetechnative/terraform-aws-ecs/tflint.yaml?style=plastic)

<!-- SHIELDS -->

This module implements an ecs cluster.

[![](we-are-technative.png)](https://www.technative.nl)

## How does it work

### First use after you clone this repository or when .pre-commit-config.yaml is updated

Run `pre-commit install` to install any guardrails implemented using pre-commit.

See [pre-commit installation](https://pre-commit.com/#install) on how to install pre-commit.


## Usage

To use this module ...

```hcl
{
  some_conf = "might need explanation"
}
````
<!-- BEGIN_TERRAFORM_DOMAINS -->
## Domain: ecs_service

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.18.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=4.18.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_autoscaling"></a> [autoscaling](#module\_autoscaling) | ./autoscaling | n/a |
| <a name="module_dns_lambda"></a> [dns\_lambda](#module\_dns\_lambda) | ./fargate_dns_lambda | n/a |
| <a name="module_task_definition"></a> [task\_definition](#module\_task\_definition) | ../ecs_task_definition | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_service_discovery_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/service_discovery_service) | resource |
| [aws_arn.ecs_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/arn) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_capacity_provider_name"></a> [capacity\_provider\_name](#input\_capacity\_provider\_name) | Capacity provider name which is always required if var.scheduling\_strategy is set to REPLICA. | `string` | n/a | yes |
| <a name="input_cloudwatch_group_name"></a> [cloudwatch\_group\_name](#input\_cloudwatch\_group\_name) | Cloudwatch log group name. | `string` | n/a | yes |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Unique name for the container. | `string` | `"application"` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | Desired count of instances to start. | `number` | `0` | no |
| <a name="input_discovery_service_namespace_id"></a> [discovery\_service\_namespace\_id](#input\_discovery\_service\_namespace\_id) | Namespace ID of discovery service. The service will have the same name as the var.name value. Requires the use of Fargate and will provide A records only.<br>WARNING: Enabling this attribute on an existing ecs\_service will not have any effect. Make sure you replace the service when you do so. | `string` | `null` | no |
| <a name="input_disovery_service_name_override"></a> [disovery\_service\_name\_override](#input\_disovery\_service\_name\_override) | If var.discovery\_service\_namespace\_id is set then the servicename is equal to the application name if this value is not set. Otherwise this value prevails. | `string` | `null` | no |
| <a name="input_docker_image_tag"></a> [docker\_image\_tag](#input\_docker\_image\_tag) | Docker image tag. | `string` | n/a | yes |
| <a name="input_docker_image_url"></a> [docker\_image\_url](#input\_docker\_image\_url) | Docker image URL without the tag component. | `string` | n/a | yes |
| <a name="input_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#input\_ecs\_cluster\_arn) | ECS cluster ARN to attach service to. | `string` | n/a | yes |
| <a name="input_execution_role_arn"></a> [execution\_role\_arn](#input\_execution\_role\_arn) | ARN of the execution role responsible for starting the container. Requires access to ECR and secrets (if used). | `string` | `null` | no |
| <a name="input_extra_container_def_string"></a> [extra\_container\_def\_string](#input\_extra\_container\_def\_string) | n/a | `string` | `""` | no |
| <a name="input_fargate_architecture"></a> [fargate\_architecture](#input\_fargate\_architecture) | Fargate architecture, defaults to X86\_64. Can also be ARM64. | `string` | `"X86_64"` | no |
| <a name="input_fargate_assign_public_ip"></a> [fargate\_assign\_public\_ip](#input\_fargate\_assign\_public\_ip) | Assign public IP if Fargate is used. | `bool` | `false` | no |
| <a name="input_force_new_deployment"></a> [force\_new\_deployment](#input\_force\_new\_deployment) | Apply any changes immediatly if a decision can be made. Recommended for testing environments but not for production. | `bool` | n/a | yes |
| <a name="input_healthcheck_command"></a> [healthcheck\_command](#input\_healthcheck\_command) | If set then will use a command to check the container health. | `string` | `null` | no |
| <a name="input_healthcheck_grace_period"></a> [healthcheck\_grace\_period](#input\_healthcheck\_grace\_period) | Number of seconds to ignore failing tasks. This is needed for containers that take a long time to start and respond to healthchecks. | `number` | `0` | no |
| <a name="input_hosted_zone_id"></a> [hosted\_zone\_id](#input\_hosted\_zone\_id) | Optionally set hosted zone ID to maintain a DNS record for the Fargate pod. Requires the use of fargate and will only work effectively if only one task is used. | `string` | `null` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | KMS key for at rest encryption purposes. | `string` | n/a | yes |
| <a name="input_linux_capabilities"></a> [linux\_capabilities](#input\_linux\_capabilities) | Add additional capabilities to allow kernel access for e.g. OpenVPN servers. Requires EC2 launch, will not work with Fargate. | `list(string)` | `[]` | no |
| <a name="input_linux_expose_devices"></a> [linux\_expose\_devices](#input\_linux\_expose\_devices) | Expose certain kernel devices that are generally hidden to support e.g. OpenVPN servers. Requires EC2 launch, will not work with Fargate. | `list(string)` | `[]` | no |
| <a name="input_load_balancer_config"></a> [load\_balancer\_config](#input\_load\_balancer\_config) | Load balancer configuration for target groups. Container\_name is optional and will be overwritten by var.name if not specified. | <pre>map(object({<br>    target_group_arn = string<br>    container_port = number<br>    container_name = string<br>  }))</pre> | `{}` | no |
| <a name="input_max_number_of_tasks"></a> [max\_number\_of\_tasks](#input\_max\_number\_of\_tasks) | Initial task amount is set to 0. Set to >1 for autoscaling and use this value as a maximum. Use 0 or 1 to disable autoscaling and handle the amount of pods in the web console. | `number` | n/a | yes |
| <a name="input_min_number_of_tasks"></a> [min\_number\_of\_tasks](#input\_min\_number\_of\_tasks) | Initial task amount is set to 0. | `number` | `0` | no |
| <a name="input_name"></a> [name](#input\_name) | Unique name for the service within the ECS cluster. | `string` | n/a | yes |
| <a name="input_scaling_down_cooldown"></a> [scaling\_down\_cooldown](#input\_scaling\_down\_cooldown) | Amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start when scaling down (agressiveness) | `number` | `900` | no |
| <a name="input_scaling_down_high"></a> [scaling\_down\_high](#input\_scaling\_down\_high) | Number of tasks to scale down by when upper bound is reached | `number` | `-3` | no |
| <a name="input_scaling_down_low"></a> [scaling\_down\_low](#input\_scaling\_down\_low) | Number of tasks to scale down by when lower bound is reached | `number` | `-1` | no |
| <a name="input_scaling_up_cooldown"></a> [scaling\_up\_cooldown](#input\_scaling\_up\_cooldown) | Amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start when scaling up (agressiveness) | `number` | `300` | no |
| <a name="input_scaling_up_high"></a> [scaling\_up\_high](#input\_scaling\_up\_high) | Number of tasks to scale up by when upper bound is reached | `number` | `5` | no |
| <a name="input_scaling_up_low"></a> [scaling\_up\_low](#input\_scaling\_up\_low) | Number of tasks to scale up by when lower bound is reached | `number` | `3` | no |
| <a name="input_scheduling_strategy"></a> [scheduling\_strategy](#input\_scheduling\_strategy) | ECS scheduling strategy to use. | `string` | `"REPLICA"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security groups to assign. | `list(string)` | n/a | yes |
| <a name="input_sqs_dlq_arn"></a> [sqs\_dlq\_arn](#input\_sqs\_dlq\_arn) | SQS DLQ Arn to send failed infra events to. Currently only used for the DNS Fargate Lambda. | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Private subnets with a NAT gateway to route traffic for tasks. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to be added to resources. | `map(string)` | `{}` | no |
| <a name="input_task_cpu_units"></a> [task\_cpu\_units](#input\_task\_cpu\_units) | Required CPU units for the task (and Fargate instance). | `number` | n/a | yes |
| <a name="input_task_definition_command"></a> [task\_definition\_command](#input\_task\_definition\_command) | overriding docker command, skip to use image default command. | `list(string)` | `[]` | no |
| <a name="input_task_definition_environment_variables"></a> [task\_definition\_environment\_variables](#input\_task\_definition\_environment\_variables) | Map of nonsecret environment variables with the value of an SSM parameter where this value is stored. | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_task_definition_secrets"></a> [task\_definition\_secrets](#input\_task\_definition\_secrets) | Map of secret environment variables with the value of an SSM parameter where this value is stored. | <pre>list(object({<br>    name      = string<br>    valueFrom = string<br>  }))</pre> | `[]` | no |
| <a name="input_task_memory_units"></a> [task\_memory\_units](#input\_task\_memory\_units) | Required memory units for the task (and Fargate instance). | `number` | n/a | yes |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | ARN of the role which the container software can use to get privileges. One policy for execution-command will be assigned to this task\_role. | `string` | n/a | yes |
| <a name="input_threshold_cpu_high"></a> [threshold\_cpu\_high](#input\_threshold\_cpu\_high) | Theshold for cpu high alarm which will trigger upscaling | `number` | `50` | no |
| <a name="input_threshold_cpu_low"></a> [threshold\_cpu\_low](#input\_threshold\_cpu\_low) | Theshold for cpu low alarm which will trigger downscaling | `number` | `20` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_service_arn"></a> [ecs\_service\_arn](#output\_ecs\_service\_arn) | n/a |
| <a name="output_ecs_task_definition_arn"></a> [ecs\_task\_definition\_arn](#output\_ecs\_task\_definition\_arn) | n/a |

## Domain: ecs_cluster

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.18.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=4.18.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_iam_policy_document.instance_ecs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_insights"></a> [container\_insights](#input\_container\_insights) | Enable container insights. | `string` | `"enabled"` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | KMS key arn for CI encryption. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Unique name for ECS cluster powered by Fargate. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to be added to resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_instance_role_ecs_policy"></a> [ec2\_instance\_role\_ecs\_policy](#output\_ec2\_instance\_role\_ecs\_policy) | n/a |
| <a name="output_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#output\_ecs\_cluster\_arn) | n/a |
| <a name="output_ecs_cluster_name"></a> [ecs\_cluster\_name](#output\_ecs\_cluster\_name) | n/a |

## Domain: ecs_fargate_capacity_provider

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.18.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=4.18.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_cluster_capacity_providers.fargate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster_capacity_providers) | resource |
| [aws_arn.ecs_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/arn) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#input\_ecs\_cluster\_arn) | ARN of an existing ECS cluster where the capacity provider must be assigned to. This is a requirement in order to use a capacity provider in a service. | `string` | n/a | yes |
| <a name="input_use_spot"></a> [use\_spot](#input\_use\_spot) | Use spot instances instead of continuous instances. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_capacity_provider_name"></a> [capacity\_provider\_name](#output\_capacity\_provider\_name) | n/a |

## Domain: ecs_scheduled_task

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.18.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=4.18.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eventbridge_role"></a> [eventbridge\_role](#module\_eventbridge\_role) | git@github.com:TechNative-B-V/modules-aws.git//identity_and_access_management/iam_role | e3c1a1f94ffa77c5f787d44ec98e2028c824220a |
| <a name="module_task_definition"></a> [task\_definition](#module\_task\_definition) | ../ecs_task_definition | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_target.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_arn.ecs_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/arn) | data source |
| [aws_iam_policy_document.passrole](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.runtask](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_group_name"></a> [cloudwatch\_group\_name](#input\_cloudwatch\_group\_name) | Cloudwatch log group name. | `string` | n/a | yes |
| <a name="input_docker_image_tag"></a> [docker\_image\_tag](#input\_docker\_image\_tag) | Docker image tag. | `string` | n/a | yes |
| <a name="input_docker_image_url"></a> [docker\_image\_url](#input\_docker\_image\_url) | Docker image URL without the tag component. | `string` | n/a | yes |
| <a name="input_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#input\_ecs\_cluster\_arn) | ECS cluster ARN to attach service to. | `string` | n/a | yes |
| <a name="input_eventbridge_event_rule_name"></a> [eventbridge\_event\_rule\_name](#input\_eventbridge\_event\_rule\_name) | Eventbridge rule to write this container to. | `string` | `null` | no |
| <a name="input_execution_role_arn"></a> [execution\_role\_arn](#input\_execution\_role\_arn) | ARN of the execution role responsible for starting the container. Requires access to ECR and secrets (if used). | `string` | `null` | no |
| <a name="input_fargate_architecture"></a> [fargate\_architecture](#input\_fargate\_architecture) | Fargate architecture, defaults to X86\_64. Can also be ARM64. | `string` | `"X86_64"` | no |
| <a name="input_fargate_assign_public_ip"></a> [fargate\_assign\_public\_ip](#input\_fargate\_assign\_public\_ip) | Assign public IP if Fargate is used. | `bool` | `false` | no |
| <a name="input_healthcheck_command"></a> [healthcheck\_command](#input\_healthcheck\_command) | If set then will use a command to check the container health. | `string` | `null` | no |
| <a name="input_linux_capabilities"></a> [linux\_capabilities](#input\_linux\_capabilities) | Add additional capabilities to allow kernel access for e.g. OpenVPN servers. Requires EC2 launch, will not work with Fargate. | `list(string)` | `[]` | no |
| <a name="input_linux_expose_devices"></a> [linux\_expose\_devices](#input\_linux\_expose\_devices) | Expose certain kernel devices that are generally hidden to support e.g. OpenVPN servers. Requires EC2 launch, will not work with Fargate. | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Unique name for the service within the ECS cluster. | `string` | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security groups to assign. | `list(string)` | n/a | yes |
| <a name="input_sqs_dlq_arn"></a> [sqs\_dlq\_arn](#input\_sqs\_dlq\_arn) | SQS DLQ Arn to send failed infra events to. Currently only used for the DNS Fargate Lambda. | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Private subnets with a NAT gateway to route traffic for tasks. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to be added to resources. | `map(string)` | `{}` | no |
| <a name="input_task_cpu_units"></a> [task\_cpu\_units](#input\_task\_cpu\_units) | Required CPU units for the task (and Fargate instance). | `number` | n/a | yes |
| <a name="input_task_definition_command"></a> [task\_definition\_command](#input\_task\_definition\_command) | overriding docker command, skip to use image default command. | `list(string)` | `[]` | no |
| <a name="input_task_definition_environment_variables"></a> [task\_definition\_environment\_variables](#input\_task\_definition\_environment\_variables) | Map of nonsecret environment variables with the value of an SSM parameter where this value is stored. | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_task_definition_secrets"></a> [task\_definition\_secrets](#input\_task\_definition\_secrets) | Map of secret environment variables with the value of an SSM parameter where this value is stored. | <pre>list(object({<br>    name      = string<br>    valueFrom = string<br>  }))</pre> | `[]` | no |
| <a name="input_task_memory_units"></a> [task\_memory\_units](#input\_task\_memory\_units) | Required memory units for the task (and Fargate instance). | `number` | n/a | yes |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | ARN of the role which the container software can use to get privileges. One policy for execution-command will be assigned to this task\_role. | `string` | n/a | yes |

## Outputs

No outputs.

## Domain: ecs_task_definition

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.18.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=4.18.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_policy.ssm_session](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.ssm_session](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.ssm_session](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_group_name"></a> [cloudwatch\_group\_name](#input\_cloudwatch\_group\_name) | Cloudwatch log group name. | `string` | n/a | yes |
| <a name="input_command"></a> [command](#input\_command) | If set then will use a command to override the image command. Format as list with command arguments. E.g. ["bundle", "exec", "rails", "s"] | `list(string)` | `[]` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Unique name for the task container. | `string` | `"application"` | no |
| <a name="input_docker_image_tag"></a> [docker\_image\_tag](#input\_docker\_image\_tag) | Docker image tag. | `string` | n/a | yes |
| <a name="input_docker_image_url"></a> [docker\_image\_url](#input\_docker\_image\_url) | Docker image URL without the tag component. | `string` | n/a | yes |
| <a name="input_execution_role_arn"></a> [execution\_role\_arn](#input\_execution\_role\_arn) | ARN of the execution role responsible for starting the container. Requires access to ECR and secrets (if used). | `string` | `null` | no |
| <a name="input_extra_container_def_string"></a> [extra\_container\_def\_string](#input\_extra\_container\_def\_string) | n/a | `string` | `""` | no |
| <a name="input_fargate_architecture"></a> [fargate\_architecture](#input\_fargate\_architecture) | Fargate architecture, defaults to X86\_64. Can also be ARM64. | `string` | `"X86_64"` | no |
| <a name="input_healthcheck_command"></a> [healthcheck\_command](#input\_healthcheck\_command) | If set then will use a command to check the container health. | `string` | `null` | no |
| <a name="input_linux_capabilities"></a> [linux\_capabilities](#input\_linux\_capabilities) | Add additional capabilities to allow kernel access for e.g. OpenVPN servers. | `list(string)` | `[]` | no |
| <a name="input_linux_expose_devices"></a> [linux\_expose\_devices](#input\_linux\_expose\_devices) | Expose certain kernel devices that are generally hidden to support e.g. OpenVPN servers. | `list(string)` | `[]` | no |
| <a name="input_load_balancer_config"></a> [load\_balancer\_config](#input\_load\_balancer\_config) | Load balancer configuration for target groups. Container\_name is optional and will be overwritten by var.name if not specified. | <pre>map(object({<br>    target_group_arn = string<br>    container_port = number<br>    container_name = string<br>  }))</pre> | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Unique name for the task definition. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to be added to resources. | `map(string)` | `{}` | no |
| <a name="input_task_cpu_units"></a> [task\_cpu\_units](#input\_task\_cpu\_units) | Required CPU units for the task (and Fargate instance). | `number` | n/a | yes |
| <a name="input_task_definition_environment_variables"></a> [task\_definition\_environment\_variables](#input\_task\_definition\_environment\_variables) | Map of nonsecret environment variables with the value of an SSM parameter where this value is stored. | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_task_definition_secrets"></a> [task\_definition\_secrets](#input\_task\_definition\_secrets) | Map of secret environment variables with the value of an SSM parameter where this value is stored. | <pre>list(object({<br>    name      = string<br>    valueFrom = string<br>  }))</pre> | `[]` | no |
| <a name="input_task_memory_units"></a> [task\_memory\_units](#input\_task\_memory\_units) | Required memory units for the task (and Fargate instance). | `number` | n/a | yes |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | ARN of the role which the container software can use to get privileges. One policy for execution-command will be assigned to this task\_role. | `string` | n/a | yes |
| <a name="input_use_fargate"></a> [use\_fargate](#input\_use\_fargate) | Enable Fargate containers. | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_task_definition_arn"></a> [task\_definition\_arn](#output\_task\_definition\_arn) | n/a |

## Domain: ecs_account_settings

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.18.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=4.18.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_account_setting_default.aws_vpc_trunking](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_account_setting_default) | resource |
| [aws_ecs_account_setting_default.container_insights](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_account_setting_default) | resource |
| [aws_ecs_account_setting_default.container_instance_long_arn_format](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_account_setting_default) | resource |
| [aws_ecs_account_setting_default.service_long_arn_format](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_account_setting_default) | resource |
| [aws_ecs_account_setting_default.task_long_arn_format](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_account_setting_default) | resource |

## Inputs

No inputs.

## Outputs

No outputs.

## Domain: ecs_default_service_linked_role

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.18.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=4.18.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_service_linked_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |

## Inputs

No inputs.

## Outputs

No outputs.

<!-- END_TERRAFORM_DOMAINS -->

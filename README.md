> START INSTRUCTION FOR TECHNATIVE ENGINEERS

# terraform-aws-module-template

Template for creating a new TerraForm AWS Module. For TechNative Engineers.

## Instructions

### Your Module Name

Think hard and come up with the shortest descriptive name for your module.
Look at competition in the [terraform
registry](https://registry.terraform.io/).

Your module name should be max. three words seperated by dashes. E.g.

- html-form-action
- new-account-notifier
- budget-alarms
- fix-missing-tags

### Setup Github Project

1. Click the template button on the top right...
1. Name github project `terraform-aws-[your-module-name]`
1. Make project private untill ready for publication
1. Add a description in the `About` section (top right)
1. Add tags: `terraform`, `terraform-module`, `aws` and more tags relevant to your project: e.g. `s3`, `lambda`, `sso`, etc..
1. Install `pre-commit`

### Develop your module

1. Develop your module
1. Try to use the [best practices for TerraForm
   development](https://www.terraform-best-practices.com/) and [TerraForm AWS
   Development](https://github.com/ozbillwang/terraform-best-practices).

## Finish project documentation

1. Set well written title
2. Add one or more shields
3. Start readme with a short and complete as possible module description. This
   is the part where you sell your module.
4. Complete README with well written documentation. Try to think as a someone
   with three months of Terraform experience.
5. Check if pre-commit correctly generates the standard Terraform documentation.

## Publish module

If your module is in a state that it could be useful for others and ready for
publication, you can publish a first version.

1. Create a [Github
   Release](https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases)
2. Publish in the TerraForm Registry under the Technative Namespace (the GitHub
   Repo must be in the TechNative Organization)

---

> END INSTRUCTION FOR TECHNATIVE ENGINEERS


# Terraform AWS [Module Name] ![](https://img.shields.io/github/workflow/status/TechNative-B-V/terraform-aws-module-name/tflint.yaml?style=plastic)

<!-- SHIELDS -->

This module implements ...

[![](we-are-technative.png)](https://www.technative.nl)

## How does it work

### First use after you clone this repository or when .pre-commit-config.yaml is updated

Run `pre-commit install` to install any guardrails implemented using pre-commit.

See [pre-commit installation](https://pre-commit.com/#install) on how to install pre-commit.

...

## Usage

To use this module ...

```hcl
{
  some_conf = "might need explanation"
}
```

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.22.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.equinet_app_cpu_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.equinet_app_memory_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.equinet_app_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_cloudwatch_log_group.equinet_app_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_stream.equinet_app_log_stream](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream) | resource |
| [aws_cloudwatch_metric_alarm.equinet_app_cpu_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.equinet_app_memory_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_ecr_repository.equinet_app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecs_service.equinet_app_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_service.hello_world_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.equinet_app_task_definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_ecs_task_definition.hello_world_task_definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to use | `string` | `"us-east-1"` | no |
| <a name="input_equinet_app_cpu_scale_up"></a> [equinet\_app\_cpu\_scale\_up](#input\_equinet\_app\_cpu\_scale\_up) | The CPU utilization threshold to trigger a scale up event | `number` | `80` | no |
| <a name="input_equinet_app_cpu_target_value"></a> [equinet\_app\_cpu\_target\_value](#input\_equinet\_app\_cpu\_target\_value) | The target value for the CPU utilization auto scaling policy | `number` | `50` | no |
| <a name="input_equinet_app_max_capacity"></a> [equinet\_app\_max\_capacity](#input\_equinet\_app\_max\_capacity) | The maximum capacity for the Rails app auto scaling target | `number` | `5` | no |
| <a name="input_equinet_app_memory_scale_up"></a> [equinet\_app\_memory\_scale\_up](#input\_equinet\_app\_memory\_scale\_up) | The memory utilization threshold to trigger a scale up event | `number` | `80` | no |
| <a name="input_equinet_app_memory_target_value"></a> [equinet\_app\_memory\_target\_value](#input\_equinet\_app\_memory\_target\_value) | The target value for the memory utilization auto scaling policy | `number` | `50` | no |
| <a name="input_equinet_app_min_capacity"></a> [equinet\_app\_min\_capacity](#input\_equinet\_app\_min\_capacity) | The minimum capacity for the Rails app auto scaling target | `number` | `1` | no |
| <a name="input_equinet_app_port"></a> [equinet\_app\_port](#input\_equinet\_app\_port) | The port to use for the Rails app | `number` | `80` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_equinet_app_cpu_alarm_arn"></a> [equinet\_app\_cpu\_alarm\_arn](#output\_equinet\_app\_cpu\_alarm\_arn) | The ARN of the CPU utilization CloudWatch alarm for the Rails app |
| <a name="output_equinet_app_ecr_repository_url"></a> [equinet\_app\_ecr\_repository\_url](#output\_equinet\_app\_ecr\_repository\_url) | n/a |
| <a name="output_equinet_app_memory_alarm_arn"></a> [equinet\_app\_memory\_alarm\_arn](#output\_equinet\_app\_memory\_alarm\_arn) | The ARN of the memory utilization CloudWatch alarm for the Rails app |
| <a name="output_equinet_app_service_arn"></a> [equinet\_app\_service\_arn](#output\_equinet\_app\_service\_arn) | The ARN of the Rails app service |
| <a name="output_equinet_app_service_desired_count"></a> [equinet\_app\_service\_desired\_count](#output\_equinet\_app\_service\_desired\_count) | The desired count of tasks for the Rails app service |
| <a name="output_equinet_app_service_name"></a> [equinet\_app\_service\_name](#output\_equinet\_app\_service\_name) | The name of the Rails app service |
| <a name="output_equinet_app_service_pending_count"></a> [equinet\_app\_service\_pending\_count](#output\_equinet\_app\_service\_pending\_count) | The pending count of tasks for the Rails app service |
| <a name="output_equinet_app_service_running_count"></a> [equinet\_app\_service\_running\_count](#output\_equinet\_app\_service\_running\_count) | The running count of tasks for the Rails app service |
| <a name="output_equinet_app_task_definition_arn"></a> [equinet\_app\_task\_definition\_arn](#output\_equinet\_app\_task\_definition\_arn) | The ARN of the Rails app task definition |
| <a name="output_equinet_app_url"></a> [equinet\_app\_url](#output\_equinet\_app\_url) | The URL of the Rails app load balancer |
<!-- END_TF_DOCS -->

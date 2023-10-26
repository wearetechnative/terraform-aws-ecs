variable "name" {
  description = "Unique name for the service within the ECS cluster."
  type        = string
}

variable "capacity_provider_name" {
  description = "Capacity provider name which is always required if var.scheduling_strategy is set to REPLICA."
  type        = string
}

variable "ecs_cluster_arn" {
  description = "ECS cluster ARN to attach service to."
  type        = string
}

variable "force_new_deployment" {
  description = "Apply any changes immediatly if a decision can be made. Recommended for testing environments but not for production."
  type        = bool
}

variable "max_number_of_tasks" {
  description = "Initial task amount is set to 0. Set to >1 for autoscaling and use this value as a maximum. Use 0 or 1 to disable autoscaling and handle the amount of pods in the web console."
  type        = number
}

variable "healthcheck_grace_period" {
  description = "Number of seconds to ignore failing tasks. This is needed for containers that take a long time to start and respond to healthchecks."
  type        = number
  default     = 0
}

variable "subnet_ids" {
  description = "Private subnets with a NAT gateway to route traffic for tasks."
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups to assign."
  type        = list(string)
}

variable "task_cpu_units" {
  description = "Required CPU units for the task (and Fargate instance)."
  type        = number
}

variable "execution_role_arn" {
  description = "ARN of the execution role responsible for starting the container. Requires access to ECR and secrets (if used)."
  type        = string
  default     = null
}

variable "task_memory_units" {
  description = "Required memory units for the task (and Fargate instance)."
  type        = number
}

variable "task_role_arn" {
  description = "ARN of the role which the container software can use to get privileges. One policy for execution-command will be assigned to this task_role."
  type        = string
}

variable "docker_image_url" {
  description = "Docker image URL without the tag component."
  type        = string
}

variable "docker_image_tag" {
  description = "Docker image tag."
  type        = string
}

variable "cloudwatch_group_name" {
  description = "Cloudwatch log group name."
  type        = string
}

variable "task_definition_secrets" {
  description = "Map of secret environment variables with the value of an SSM parameter where this value is stored."
  type = list(object({
    name      = string
    valueFrom = string
  }))
  default = []
}

variable "task_definition_environment_variables" {
  description = "Map of nonsecret environment variables with the value of an SSM parameter where this value is stored."
  type = list(object({
    name  = string
    value = string
  }))

  default = []
}

variable "scheduling_strategy" {
  description = "ECS scheduling strategy to use."
  type        = string
  default     = "REPLICA"
}

variable "linux_capabilities" {
  description = "Add additional capabilities to allow kernel access for e.g. OpenVPN servers. Requires EC2 launch, will not work with Fargate."
  type        = list(string)
  default     = []
}

variable "linux_expose_devices" {
  description = "Expose certain kernel devices that are generally hidden to support e.g. OpenVPN servers. Requires EC2 launch, will not work with Fargate."
  type        = list(string)
  default     = []
}

variable "fargate_assign_public_ip" {
  description = "Assign public IP if Fargate is used."
  type        = bool
  default     = false
}

variable "fargate_architecture" {
  description = "Fargate architecture, defaults to X86_64. Can also be ARM64."
  type        = string
  default     = "X86_64"
}

variable "kms_key_arn" {
  description = "KMS key for at rest encryption purposes."
  type        = string
}

variable "sqs_dlq_arn" {
  description = "SQS DLQ Arn to send failed infra events to. Currently only used for the DNS Fargate Lambda."
  type        = string
}

variable "hosted_zone_id" {
  description = "Optionally set hosted zone ID to maintain a DNS record for the Fargate pod. Requires the use of fargate and will only work effectively if only one task is used."
  type        = string
  default     = null
}

variable "discovery_service_namespace_id" {
  description = <<EOT
Namespace ID of discovery service. The service will have the same name as the var.name value. Requires the use of Fargate and will provide A records only.
WARNING: Enabling this attribute on an existing ecs_service will not have any effect. Make sure you replace the service when you do so.
EOT
  type        = string
  default     = null
}

variable "disovery_service_name_override" {
  description = "If var.discovery_service_namespace_id is set then the servicename is equal to the application name if this value is not set. Otherwise this value prevails."
  type = string
  default = null
}

variable "load_balancer_config" {
  description = "Load balancer configuration for target groups. Container_name is optional and will be overwritten by var.name if not specified."
  type = map(object({
    target_group_arn = string
    container_port = number
    container_name = string
  }))
  default = {}
}

variable "healthcheck_command" {
  description = "If set then will use a command to check the container health."
  type = string
  default = null
}

variable "tags" {
  description = "Additional tags to be added to resources."
  type        = map(string)
  default     = {}
}
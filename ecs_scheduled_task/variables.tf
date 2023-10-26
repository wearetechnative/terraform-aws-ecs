variable "name" {
  description = "Unique name for the service within the ECS cluster."
  type        = string
}

variable "ecs_cluster_arn" {
  description = "ECS cluster ARN to attach service to."
  type        = string
}

variable "eventbridge_event_rule_name" {
  description = "Eventbridge rule to write this container to."
  type = string
  default = null
}

variable "subnet_ids" {
  description = "Private subnets with a NAT gateway to route traffic for tasks."
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups to assign."
  type        = list(string)
}

variable "sqs_dlq_arn" {
  description = "SQS DLQ Arn to send failed infra events to. Currently only used for the DNS Fargate Lambda."
  type        = string
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

variable "fargate_architecture" {
  description = "Fargate architecture, defaults to X86_64. Can also be ARM64."
  type        = string
  default     = "X86_64"
}

variable "healthcheck_command" {
  description = "If set then will use a command to check the container health."
  type = string
  default = null
}

variable "fargate_assign_public_ip" {
  description = "Assign public IP if Fargate is used."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags to be added to resources."
  type        = map(string)
  default     = {}
}
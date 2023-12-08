variable "name" {
  description = "Unique name for the task definition."
  type        = string
}

variable "container_name" {
  description = "Unique name for the task container."
  type        = string
  default     = "application"
}

variable "use_fargate" {
  description = "Enable Fargate containers."
  type = bool
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
  description = "Add additional capabilities to allow kernel access for e.g. OpenVPN servers."
  type        = list(string)
  default     = []
}

variable "linux_expose_devices" {
  description = "Expose certain kernel devices that are generally hidden to support e.g. OpenVPN servers."
  type        = list(string)
  default     = []
}

variable "fargate_architecture" {
  description = "Fargate architecture, defaults to X86_64. Can also be ARM64."
  type        = string
  default     = "X86_64"
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

variable "command" {
  description = "If set then will use a command to override the image command. Format as list with command arguments. E.g. [\"bundle\", \"exec\", \"rails\", \"s\"]"
  type = list(string)
  default = []
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

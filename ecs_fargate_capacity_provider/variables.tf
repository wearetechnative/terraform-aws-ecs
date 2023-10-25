variable "ecs_cluster_arn" {
  description = "ARN of an existing ECS cluster where the capacity provider must be assigned to. This is a requirement in order to use a capacity provider in a service."
  type        = string
}

variable "use_spot" {
  description = "Use spot instances instead of continuous instances."
  type = bool
  default = false
}

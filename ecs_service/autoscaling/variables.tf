variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
}

variable "scale_target_max_capacity" {
  description = "The max capacity of the scalable target"
  default     = 5
  type        = number
}

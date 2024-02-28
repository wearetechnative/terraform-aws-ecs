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

variable "scaling_up_low" {
  description = "Number of tasks to scale up by when lower bound is reached"
}

variable "scaling_up_high" {
  description = "Number of tasks to scale up by when upper bound is reached"
}

variable "scaling_down_low" {
  description = "Number of tasks to scale down by when lower bound is reached"
}

variable "scaling_down_high" {
  description = "Number of tasks to scale down by when upper bound is reached"
}

variable "threshold_cpu_high" {
  description = "Theshold for cpu high alarm which will trigger upscaling"  
}

variable "threshold_cpu_low" {
  description = "Theshold for cpu low alarm which will trigger downscaling"  
}

variable "scaling_up_cooldown" {
  description = "Amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start when scaling up (agressiveness)"
}

variable "scaling_down_cooldown" {
  description = "Amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start when scaling down (agressiveness)"
}
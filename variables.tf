variable "aws_region" {
  description = "The AWS region to use"
  default     = "us-east-1"
}

variable "equinet_app_port" {
  description = "The port to use for the Rails app"
  default     = 80
}

variable "equinet_app_cpu_scale_up" {
  description = "The CPU utilization threshold to trigger a scale up event"
  default     = 80
}

variable "equinet_app_memory_scale_up" {
  description = "The memory utilization threshold to trigger a scale up event"
  default     = 80
}

variable "equinet_app_cpu_target_value" {
  description = "The target value for the CPU utilization auto scaling policy"
  default     = 50
}

variable "equinet_app_memory_target_value" {
  description = "The target value for the memory utilization auto scaling policy"
  default     = 50
}

variable "equinet_app_max_capacity" {
  description = "The maximum capacity for the Rails app auto scaling target"
  default     = 5
}

variable "equinet_app_min_capacity" {
  description = "The minimum capacity for the Rails app auto scaling target"
  default     = 1
}

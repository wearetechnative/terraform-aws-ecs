module "autoscaling" {
  count = var.max_number_of_tasks > 1 ? 1 : 0

  source = "./autoscaling"

  ecs_cluster_name = substr(data.aws_arn.ecs_cluster.resource, length("cluster/"), -1)
  ecs_service_name = aws_ecs_service.this.name
  scale_target_max_capacity = var.max_number_of_tasks
  
  scaling_up_low    = var.scaling_up_low
  scaling_up_high   = var.scaling_up_high
  scaling_down_low  = var.scaling_down_low
  scaling_down_high = var.scaling_down_high
  threshold_cpu_high = var.threshold_cpu_high
  threshold_cpu_low = var.threshold_cpu_low
  scaling_up_cooldown = var.scaling_up_cooldown
  scaling_down_cooldown = var.scaling_down_cooldown

}

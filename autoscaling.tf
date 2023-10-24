# Create auto-scaling target for the Equinet rails app
resource "aws_appautoscaling_target" "equinet_app_target" {
  max_capacity       = var.equinet_app_max_capacity
  min_capacity       = var.equinet_app_min_capacity
  resource_id        = "service/${module.ecs.name}/${aws_ecs_service.equinet_app_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

# Create an auto-scaling policy for the Equinet rails app
# For CPU
resource "aws_appautoscaling_policy" "equinet_app_cpu_policy" {
  name               = "equinet-app-cpu-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.equinet_app_target.resource_id
  scalable_dimension = aws_appautoscaling_target.equinet_app_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.equinet_app_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = var.equinet_app_cpu_target_value
  }
}

#For memory
resource "aws_appautoscaling_policy" "equinet_app_memory_policy" {
  name               = "equinet-app-memory-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.equinet_app_target.resource_id
  scalable_dimension = aws_appautoscaling_target.equinet_app_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.equinet_app_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    target_value = var.equinet_app_memory_target_value
  }
}

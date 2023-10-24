# Create a cloudwatch log group for the Equinet rails app
resource "aws_cloudwatch_log_group" "equinet_app_log_group" {
  name = "/ecs/equinet-app"
}


# Create a log stream for the Equinet rails app
resource "aws_cloudwatch_log_stream" "equinet_app_log_stream" {
  name            = "equinet-app-container"
  log_group_name  = aws_cloudwatch_log_group.equinet_app_log_group.name
  depends_on      = [aws_cloudwatch_log_group.equinet_app_log_group]
}

# Create cloudwatch alarms for the Equinet rails app
resource "aws_cloudwatch_metric_alarm" "equinet_app_cpu_alarm" {
  alarm_name          = "equinet-app-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.equinet_app_cpu_scale_up
  alarm_description   = "This metric monitors the CPU utilization of the Rails app service."
  alarm_actions       = [aws_appautoscaling_policy.equinet_app_cpu_policy.arn]
  dimensions = {
    ClusterName = module.ecs.cluster_name
    ServiceName = aws_ecs_service.equinet_app_service.name
  }
}

resource "aws_cloudwatch_metric_alarm" "equinet_app_memory_alarm" {
  alarm_name          = "equinet-app-memory-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.equinet_app_memory_scale_up
  alarm_description   = "This metric monitors the memory utilization of the Rails app service."
  alarm_actions       = [aws_appautoscaling_policy.equinet_app_memory_policy.arn]
  dimensions = {
    ClusterName = module.ecs.cluster_name
    ServiceName = aws_ecs_service.equinet_app_service.name
  }
}



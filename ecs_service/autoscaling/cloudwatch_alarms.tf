resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${var.ecs_cluster_name}-${var.ecs_service_name}-cpu-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 5
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Maximum"
  threshold           = var.threshold_cpu_high
  alarm_description   = "Autoscaling_alarm"

  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = var.ecs_service_name
  }

  alarm_actions = [aws_appautoscaling_policy.scale_up_policy.arn]
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "${var.ecs_cluster_name}-${var.ecs_service_name}-cpu-low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 5
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Maximum"
  threshold           = var.threshold_cpu_low
  alarm_description   = "Autoscaling_alarm"

  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = var.ecs_service_name
  }

  alarm_actions = [aws_appautoscaling_policy.scale_down_policy.arn]
}

resource "aws_appautoscaling_policy" "scale_up_policy" {
  name               = "${var.ecs_cluster_name}-${var.ecs_service_name}-up"
  policy_type = "StepScaling"
  service_namespace  = "ecs"
  resource_id        = "service/${var.ecs_cluster_name}/${var.ecs_service_name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scaling_up_cooldown
    metric_aggregation_type = "Maximum" # aggressive / fast scale up

    step_adjustment {
      metric_interval_lower_bound = null
      metric_interval_upper_bound = 10
      scaling_adjustment          = var.scaling_up_low
    }

    step_adjustment {
      metric_interval_lower_bound = 10
      metric_interval_upper_bound = null
      scaling_adjustment          = var.scaling_up_high
    }
  }

  depends_on         = [aws_appautoscaling_target.this]
}

resource "aws_appautoscaling_policy" "scale_down_policy" {
  name               = "${var.ecs_cluster_name}-${var.ecs_service_name}-down"
  policy_type = "StepScaling"
  service_namespace  = "ecs"
  resource_id        = "service/${var.ecs_cluster_name}/${var.ecs_service_name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scaling_down_cooldown
    metric_aggregation_type = "Average" # slow scale down

    step_adjustment {
      metric_interval_lower_bound = -10
      metric_interval_upper_bound = null
      scaling_adjustment          = var.scaling_down_low
    }

    step_adjustment {
      metric_interval_lower_bound = null
      metric_interval_upper_bound = -10
      scaling_adjustment          = var.scaling_down_high
    }
  }

  depends_on         = [aws_appautoscaling_target.this]
}

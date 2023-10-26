resource "aws_appautoscaling_policy" "scale_up_policy" {
  name               = "${var.ecs_cluster_name}-${var.ecs_service_name}-up"
  policy_type = "StepScaling"
  service_namespace  = "ecs"
  resource_id        = "service/${var.ecs_cluster_name}/${var.ecs_service_name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 300 # aggressive / fast scale up
    metric_aggregation_type = "Maximum" # aggressive / fast scale up

    step_adjustment {
      metric_interval_lower_bound = null
      metric_interval_upper_bound = 10
      scaling_adjustment          = 3 # aggressive / fast scale up
    }

    step_adjustment {
      metric_interval_lower_bound = 10
      metric_interval_upper_bound = null
      scaling_adjustment          = 5 # aggressive / fast scale up
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
    cooldown                = 900 # slow scale down
    metric_aggregation_type = "Average" # slow scale down

    step_adjustment {
      metric_interval_lower_bound = null
      metric_interval_upper_bound = -10
      scaling_adjustment          = -3 # faster scale down
    }

    step_adjustment {
      metric_interval_lower_bound = -10
      metric_interval_upper_bound = null
      scaling_adjustment          = -1 # slow scale down
    }
  }

  depends_on         = [aws_appautoscaling_target.this]
}

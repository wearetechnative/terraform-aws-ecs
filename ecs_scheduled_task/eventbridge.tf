resource "aws_cloudwatch_event_target" "this" {
  rule           = var.eventbridge_event_rule_name
  target_id      = var.name
  arn            = var.ecs_cluster_arn

  # input          = var.event_target_input
  # input_path     = var.event_target_input_path

  role_arn       = module.eventbridge_role.role_arn

  ecs_target {
    # group               = var.event_target_ecs_target_group

    launch_type         = "FARGATE"
    platform_version    = "LATEST"

    task_count          = 1
    task_definition_arn = module.task_definition.task_definition_arn

    propagate_tags      = "TASK_DEFINITION"
    enable_execute_command = true
    enable_ecs_managed_tags = true

    network_configuration {
      subnets          = var.subnet_ids
      security_groups  = var.security_group_ids
      assign_public_ip = var.fargate_assign_public_ip
    }

    tags = var.tags
  }

  dead_letter_config {
    arn = var.sqs_dlq_arn
  }

  retry_policy {
    maximum_event_age_in_seconds = 300
    maximum_retry_attempts = 3
  }
}

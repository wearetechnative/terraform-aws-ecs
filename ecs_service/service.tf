data "aws_arn" "ecs_cluster" {
  arn = var.ecs_cluster_arn
}

resource "aws_ecs_service" "this" {
  name = var.name

  dynamic "capacity_provider_strategy" {
    for_each = var.scheduling_strategy != "DAEMON" ? [1] : []

    content {
      capacity_provider = var.capacity_provider_name
      weight            = 1
    }
  }

  cluster = var.ecs_cluster_arn

  deployment_circuit_breaker {
    enable   = false
    rollback = false
  }

  deployment_controller {
    type = "ECS"
  }

  deployment_maximum_percent         = 200 # be fast
  deployment_minimum_healthy_percent = 100 # be robuust

  desired_count           = var.desired_count
  enable_ecs_managed_tags = true
  enable_execute_command  = true

  force_new_deployment = var.force_new_deployment

  health_check_grace_period_seconds = var.healthcheck_grace_period

  # use default since we cannot use custom suffix?
  # iam_role = aws_iam_service_linked_role.this.name # some contraditions in docs, so lets use it anyway (covers more scenarios)

  dynamic "load_balancer" {
    for_each = var.load_balancer_config

    content {
      target_group_arn = load_balancer.value.target_group_arn
      container_name   = "application" # load_balancer.value.container_name != null ? load_balancer.value.container_name : var.name
      container_port   = load_balancer.value.container_port
    }
  }

  dynamic "network_configuration" {
    for_each = local.use_fargate ? [1] : []

    content {
      subnets          = var.subnet_ids
      security_groups  = var.security_group_ids
      assign_public_ip = var.fargate_assign_public_ip
    }
  }

  dynamic "ordered_placement_strategy" {
    for_each = var.scheduling_strategy != "DAEMON" && !local.use_fargate ? tolist([{ "type" : "spread", "field" : "attribute:ecs.availability-zone" }, { "type" : "binpack", "field" : "memory" }]) : []

    content {
      type  = ordered_placement_strategy.value.type
      field = ordered_placement_strategy.value.field
    }
  }

  platform_version    = local.use_fargate ? "LATEST" : null
  propagate_tags      = "TASK_DEFINITION"
  scheduling_strategy = var.scheduling_strategy

  dynamic "service_registries" {
    for_each = local.use_fargate && length(aws_service_discovery_service.this) > 0 ? [1] : []

    content {
      registry_arn = aws_service_discovery_service.this[0].arn
      # excluded since we only use this with Fargate now and use an A record
      # port =
      # container_port = var.target_container_port
      # container_name = var.name
    }
  }

  task_definition       = module.task_definition.task_definition_arn
  wait_for_steady_state = var.force_new_deployment # wait if we reapply

  tags = var.tags

  #lifecycle {
  #  ignore_changes = [desired_count]
  #}
}

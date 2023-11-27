resource "aws_ecs_task_definition" "this" {
  family = var.name
  container_definitions = templatefile("${path.module}/task_definition.json.tftpl", {
    name                  = var.name
    image_ref             = var.docker_image_url
    image_version         = var.docker_image_tag
    compatibilities       = jsonencode(local.compatibilities)
    port_mappings         = jsonencode(distinct([ for k, v in var.load_balancer_config : { "hostPort": local.network_mode == "bridge" ? 0 : v.container_port, "containerPort": v.container_port, "protocol": "tcp" } ]))
    cloudwatch_group_name = var.cloudwatch_group_name
    aws_region            = data.aws_region.current.name
    secrets               = jsonencode(var.task_definition_secrets)
    environment_variables = jsonencode(concat(var.task_definition_environment_variables
    # allow AWS CLI to work out of the box, mind boggling isn't it? :)
    , [ { "name": "AWS_DEFAULT_REGION", "value": data.aws_region.current.name } ]))
    linux_capabilities    = jsonencode(var.linux_capabilities)
    linux_expose_devices  = jsonencode([for v in var.linux_expose_devices : { "hostPath" : "${v}", "containerPath" : "${v}", "permissions" : ["read", "write"] }])
    command = var.command
    healthcheck_command = var.healthcheck_command != null ? var.healthcheck_command : ""
    cpu_units = var.task_cpu_units
    memory_units = var.task_memory_units
  })

  cpu                = var.task_cpu_units
  execution_role_arn = var.execution_role_arn
  # inference_accelerator {}
  # ipc_mode = "none"
  memory       = var.task_memory_units
  network_mode = local.network_mode

  dynamic "runtime_platform" {
    for_each = var.use_fargate ? [1] : []

    content {
      operating_system_family = "LINUX"
      cpu_architecture        = var.fargate_architecture
    }
  }

  pid_mode = null # private namespace
  # placement_constraints {}
  # proxy_configuration {}

  dynamic "ephemeral_storage" {
    for_each = var.use_fargate ? [1] : []

    content {
      size_in_gib = 21
    }
  }

  requires_compatibilities = local.compatibilities
  task_role_arn            = var.task_role_arn

  tags = var.tags
}

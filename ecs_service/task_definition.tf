module "task_definition" {
  source = "../ecs_task_definition"

  name = "${split("cluster/", data.aws_arn.ecs_cluster.resource)[1]}_${var.name}"
  container_name = var.container_name
  use_fargate = local.use_fargate

  docker_image_url = var.docker_image_url
  docker_image_tag = var.docker_image_tag
  load_balancer_config = var.load_balancer_config
  cloudwatch_group_name = var.cloudwatch_group_name
  task_definition_secrets = var.task_definition_secrets
  task_definition_environment_variables = var.task_definition_environment_variables
  command = var.task_definition_command
  linux_capabilities = var.linux_capabilities
  linux_expose_devices = var.linux_expose_devices
  healthcheck_command = var.healthcheck_command
  task_cpu_units = var.task_cpu_units
  task_memory_units = var.task_memory_units
  execution_role_arn = var.execution_role_arn
  fargate_architecture = var.fargate_architecture
  task_role_arn = var.task_role_arn

  tags = var.tags
  extra_container_def_string = var.extra_container_def_string
}

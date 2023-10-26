locals {
  task_role_name  = split("/", var.task_role_arn)[length(split("/", var.task_role_arn)) - 1]
  cluster_name    = replace(split("cluster/", data.aws_arn.ecs_cluster.resource)[1], "_", "-")
  use_fargate     = var.subnet_ids != null || var.security_group_ids != null
  compatibilities = local.use_fargate ? ["FARGATE"] : ["EC2"]
  network_mode = local.use_fargate ? "awsvpc" : length(var.load_balancer_config) == 0 ? "host" : "bridge"
}

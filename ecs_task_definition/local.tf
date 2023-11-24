locals {
  task_role_name  = split("/", var.task_role_arn)[length(split("/", var.task_role_arn)) - 1]
  compatibilities = var.use_fargate ? ["FARGATE"] : ["EC2"]
  network_mode = var.use_fargate ? "awsvpc" : length(var.load_balancer_config) == 0 ? "host" : "bridge"
}

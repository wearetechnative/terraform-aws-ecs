module "autoscaling" {
  count = var.max_number_of_tasks > 1 ? 1 : 0

  source = "./autoscaling"

  ecs_cluster_name = substr(data.aws_arn.ecs_cluster.resource, length("cluster/"), -1)
  ecs_service_name = aws_ecs_service.this.name
  scale_target_max_capacity = var.max_number_of_tasks
}

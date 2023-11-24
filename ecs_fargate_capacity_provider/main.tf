data "aws_arn" "ecs_cluster" {
  arn = var.ecs_cluster_arn
}

resource "aws_ecs_cluster_capacity_providers" "fargate" {
  cluster_name = split("cluster/", data.aws_arn.ecs_cluster.resource)[1]

  capacity_providers = [ local.capacity_provider ]

  # must be defined by service, unreliable behaviour as default
  # default_capacity_provider_strategy {
  #   base              = 1
  #   weight            = 100
  #   capacity_provider = local.capacity_provider
  # }
}

output "capacity_provider_name" {
  # value = aws_ecs_cluster_capacity_providers.fargate.cluster_name
  # odd, but works
  value = local.capacity_provider
}

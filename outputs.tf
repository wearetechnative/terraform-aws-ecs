output "ecs_cluster_arn" {
  #value = module.ecs_cluster.ecs_cluster_arn
  value = module.ecs_cluster.ecs_cluster_arn
}

output "ec2_instance_role_ecs_policy" {
  value = module.ecs_cluster.ec2_instance_role_ecs_policy
}

output "capacity_provider_name" {
  value = module.ecs_fargate_capacity_provider.capacity_provider_name
  #value = module.ecs_fargate_capacity_provider.fargate.cluster_name
}

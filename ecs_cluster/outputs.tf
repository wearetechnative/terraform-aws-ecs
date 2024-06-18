output "ecs_cluster_arn" {
  value = aws_ecs_cluster.this.arn
}

output "ec2_instance_role_ecs_policy" {
  value = jsondecode(data.aws_iam_policy_document.instance_ecs_policy.json)
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.this.name
}

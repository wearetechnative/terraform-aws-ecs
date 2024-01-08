# NOTE this should be tested and seems to be created automatically
#resource "aws_cloudwatch_log_group" "cloudwatch_logs" {
#  name = "/aws/ecs/containerinsights/${aws_ecs_cluster.this.name}/performance"
#  kms_key_id = var.kms_key_arn
#
#  retention_in_days = 90
#
#  tags = var.tags
#}

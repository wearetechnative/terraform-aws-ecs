module "dns_lambda" {
  count = var.hosted_zone_id != null ? 1 : 0

  source = "./fargate_dns_lambda"

  name           = "${var.name}-fargate-dns-lambda"
  dns_name       = var.name
  sqs_dlq_arn    = var.sqs_dlq_arn
  kms_key_arn    = var.kms_key_arn
  cluster_arn    = var.ecs_cluster_arn
  service_name   = aws_ecs_service.this.name
  hosted_zone_id = var.hosted_zone_id
}

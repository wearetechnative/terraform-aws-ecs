resource "aws_service_discovery_service" "this" {
  count = var.discovery_service_namespace_id != null ? 1 : 0

  name = var.disovery_service_name_override != null ? var.disovery_service_name_override : var.name

  dns_config {
    namespace_id = var.discovery_service_namespace_id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }

  tags = var.tags
}

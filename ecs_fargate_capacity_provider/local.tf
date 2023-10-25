locals {
  capacity_provider = var.use_spot ? "FARGATE_SPOT" : "FARGATE"
}

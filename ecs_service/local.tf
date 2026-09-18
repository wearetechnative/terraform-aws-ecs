locals {
  use_fargate = var.subnet_ids != null || var.security_group_ids != null
}

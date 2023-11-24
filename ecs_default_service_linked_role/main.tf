resource "aws_iam_service_linked_role" "this" {
  aws_service_name = "ecs.amazonaws.com"
  description = "default service linked role"
}

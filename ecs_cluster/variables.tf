variable "name" {
  description = "Unique name for ECS cluster powered by Fargate."
  type        = string
}

variable "kms_key_arn" {
  description = "KMS key arn for CI encryption."
  type = string
}

variable "tags" {
  description = "Additional tags to be added to resources."
  type        = map(string)
  default     = {}
}

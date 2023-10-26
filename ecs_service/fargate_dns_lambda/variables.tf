variable "name" {
  description = "Unique name for EC2 with ASG setup."
  type        = string
}

variable "dns_name" {
  description = "DNS name of service."
  type        = string
}

variable "kms_key_arn" {
  description = "KMS key for encrypting CloudWatch Logs. More uses might be added later."
  type        = string
}

variable "sqs_dlq_arn" {
  description = "Required normal SQS queue to be used as DLQ for EventBridge."
  type        = string
}

variable "cluster_arn" {
  description = "Cluster ARN for listening on EventBridge events."
  type        = string
}

variable "service_name" {
  description = "Service name for listening on EventBridge events."
  type        = string
}

variable "hosted_zone_id" {
  description = "Hosted zone ID to create the A-record in. The name will be the name of the service."
  type        = string
}

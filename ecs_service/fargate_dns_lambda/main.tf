# stolen from https://github.com/hashicorp/terraform/issues/8344

module "lambda" {
  source = "git@github.com:wearetechnative/terraform-aws-lambda?ref=c8a34a903af04ff00ff8bbb95de00762553593db"

  name              = var.name
  role_arn          = module.iam_role.role_arn
  role_arn_provided = true

  handler                   = "lambda_function.lambda_handler"
  source_type               = "local"
  source_directory_location = "${path.module}/source"
  source_file_name          = null
  sqs_dlq_arn               = var.sqs_dlq_arn

  environment_variables = {
    "HOSTED_ZONE_ID" : var.hosted_zone_id
    "DNS_NAME" : var.dns_name
  }

  kms_key_arn = var.kms_key_arn
  memory_size = 128
  timeout     = 10
  runtime     = "python3.9"
}

data "aws_arn" "lambda" {
  arn = module.lambda.lambda_function_arn
}

resource "aws_lambda_function_event_invoke_config" "dlq" {
  function_name = var.name

  maximum_event_age_in_seconds = 60
  maximum_retry_attempts       = 2

  destination_config {
    on_failure {
      destination = var.sqs_dlq_arn
    }
  }

  depends_on = [
    module.lambda
  ]
}

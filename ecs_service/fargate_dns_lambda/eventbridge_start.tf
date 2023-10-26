resource "aws_cloudwatch_event_rule" "lambda_start" {
  name        = "${var.name}-start"
  description = "Sends task started events so Lambda can update DNS."

  event_bus_name = "default"
  event_pattern = jsonencode({
    "source" : ["aws.ecs"]
    "detail-type" : ["ECS Task State Change"]
    "detail" : {
      "clusterArn" : [var.cluster_arn]
      "group" : ["service:${var.service_name}"]
      "desiredStatus" : ["RUNNING"]
      "lastStatus" : ["PENDING"]
    }
  })
}

resource "aws_cloudwatch_event_target" "lambda_start" {
  rule           = aws_cloudwatch_event_rule.lambda_start.name
  event_bus_name = aws_cloudwatch_event_rule.lambda_start.event_bus_name

  arn = module.lambda.lambda_function_arn

  dead_letter_config {
    arn = var.sqs_dlq_arn
  }

  retry_policy {
    maximum_event_age_in_seconds = 60
    maximum_retry_attempts       = 3
  }
}

resource "aws_lambda_permission" "lambda_start" {
  statement_id_prefix = var.name
  action              = "lambda:InvokeFunction"
  function_name       = substr(data.aws_arn.lambda.resource, length("function:"), length(data.aws_arn.lambda.resource) - length("function:"))
  principal           = "events.amazonaws.com"
  source_arn          = aws_cloudwatch_event_rule.lambda_start.arn
}

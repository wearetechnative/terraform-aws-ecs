resource "aws_cloudwatch_event_rule" "lambda_stop" {
  name        = "${var.name}-stop"
  description = "Sends task stopped events so Lambda can update DNS."

  event_bus_name = "default"
  event_pattern = jsonencode({
    "source" : ["aws.ecs"]
    "detail-type" : ["ECS Task State Change"]
    "detail" : {
      "clusterArn" : [var.cluster_arn]
      "group" : ["service:${var.service_name}"]
      "desiredStatus" : ["STOPPED"]
      "lastStatus" : ["RUNNING"]
    }
  })
}

resource "aws_cloudwatch_event_target" "lambda_stop" {
  rule           = aws_cloudwatch_event_rule.lambda_stop.name
  event_bus_name = aws_cloudwatch_event_rule.lambda_stop.event_bus_name

  arn = module.lambda.lambda_function_arn

  dead_letter_config {
    arn = var.sqs_dlq_arn
  }

  retry_policy {
    maximum_event_age_in_seconds = 60
    maximum_retry_attempts       = 3
  }
}

resource "aws_lambda_permission" "lambda_stop" {
  statement_id_prefix = var.name
  action              = "lambda:InvokeFunction"
  function_name       = substr(data.aws_arn.lambda.resource, length("function:"), length(data.aws_arn.lambda.resource) - length("function:"))
  principal           = "events.amazonaws.com"
  source_arn          = aws_cloudwatch_event_rule.lambda_stop.arn
}

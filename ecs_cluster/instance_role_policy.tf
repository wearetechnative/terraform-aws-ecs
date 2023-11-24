data "aws_iam_policy_document" "instance_ecs_policy" {
  statement {
    actions = [ "ecs:RegisterContainerInstance", "ecs:SubmitTaskStateChange" ]
   
    resources = [ aws_ecs_cluster.this.arn ]
  }

  statement {
    actions = [ "ecs:DiscoverPollEndpoint" ]
   
    resources = ["*"]
  }

  statement {
    actions = [ "ecs:StartTelemetrySession", "ecs:Poll" ]
   
    resources = ["*"]

    condition {
      test = "StringEquals"
      variable = "ecs:cluster"
      values = [ aws_ecs_cluster.this.arn ]
    }
  }
}

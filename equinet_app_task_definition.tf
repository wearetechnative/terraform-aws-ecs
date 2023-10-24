#  Create a task definition for the Equinet rails app including cloudwatch agent
resource "aws_ecs_task_definition" "equinet_app_task_definition" {
  family                   = "equinet-app-task"
  container_definitions    = jsonencode([{
    name      = "equinet-app-container"
    image     = "${aws_ecr_repository.equinet_app.repository_url}:latest"
    portMappings = [{
      containerPort = var.equinet_app_port
      hostPort      = var.equinet_app_port
    }]
    environment = [{
      name  = "RAILS_ENV"
      value = "production"
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-region"        = var.aws_region
        "awslogs-group"         = aws_cloudwatch_log_group.equinet_app_log_group.name
        "awslogs-stream-prefix" = "equinet-app-container"
        "awslogs-create-group"  = "true"
      }
    }
  }])
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  network_mode             = "awsvpc"
}

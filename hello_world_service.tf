# Create service for Hello World PoC
resource "aws_ecs_task_definition" "hello_world_task_definition" {
  family                   = "hello-world-task"
  container_definitions    = jsonencode([{
    name      = "hello-world-container"
    image     = "hello-world:latest"
  }])
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  network_mode             = "awsvpc"
}

resource "aws_ecs_service" "hello_world_service" {
  name            = "hello-world-service"
  cluster         = module.ecs.cluster_id
  task_definition = aws_ecs_task_definition.hello_world_task_definition.arn
  desired_count   = 1

  network_configuration {
    security_groups = [module.network.default_security_group_id]
    subnets         = module.network.private_subnets
  }
}

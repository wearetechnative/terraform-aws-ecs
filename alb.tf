resource "aws_lb" "equinet_app_lb" {
  name               = "equinet-app-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.equinet_app_public_subnet_1.id, aws_subnet.equinet_app_public_subnet_2.id]
  security_groups    = [aws_security_group.equinet_app_security_group.id]
}

resource "aws_lb_target_group" "equinet_app_target_group" {
  name     = "equinet-app-target-group"
  port     = var.equinet_app_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.equinet_app_vpc.id
}

resource "aws_lb_listener" "equinet_app_listener" {
  load_balancer_arn = aws_lb.equinet_app_lb.arn
  port              = var.equinet_app_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.equinet_app_target_group.arn
    type             = "forward"
  }
}

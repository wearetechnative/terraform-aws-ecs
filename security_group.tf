resource "aws_security_group" "equinet_app_security_group" {
  name_prefix = "equinet-app-sg-"
  vpc_id      = aws_vpc.equinet_app_vpc.id

  ingress {
    from_port   = var.equinet_app_port
    to_port     = var.equinet_app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

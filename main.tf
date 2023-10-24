resource "aws_ecr_repository" "equinet_app" {
  name = "equinet-app"
}

output "equinet_app_ecr_repository_url" {
  value = aws_ecr_repository.equinet_app.repository_url
}

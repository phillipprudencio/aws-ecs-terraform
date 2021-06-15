resource "aws_cloudwatch_log_group" "main" {
  name              = "/ecs/${var.name}"
  retention_in_days = var.cloudwatch_logs_retention
  tags              = var.tags
}

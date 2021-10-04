resource "aws_lb_target_group" "main" {
  name        = "lb-target-group"
  port        = var.task_port
  protocol    = var.healthcheck_protocol
  vpc_id      = var.vpc_id
  target_type = "ip"
  tags        = var.tags
}

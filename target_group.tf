resource "aws_lb_target_group" "main" {
  count = var.no_loadbalancer ? 0 : 1
  name        = "lb-target-group"
  count       = var.no_loadbalancer ? 0 : 1
  port        = var.task_port
  protocol    = var.healthcheck_protocol
  vpc_id      = var.vpc_id
  target_type = "ip"
  tags        = var.tags
}

resource "aws_alb_target_group" "main" {
  port        = var.task_port
  protocol    = var.healthcheck_protocol
  vpc_id      = var.vpc_id
  target_type = "ip"
  tags        = var.tags

  health_check {
    interval            = var.healthcheck_interval
    path                = var.healthcheck_path
    timeout             = var.healthcheck_timeout
    matcher             = var.healthcheck_success_codes
    healthy_threshold   = var.healthcheck_healthy_threshold
    unhealthy_threshold = var.healthcheck_unhealthy_threshold
  }

  lifecycle {
    create_before_destroy = true
  }
}

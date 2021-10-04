resource "aws_lb_listener_rule" "main" {
  count = var.no_loadbalancer ? 0 : 1
  listener_arn = var.loadbalancer_rule_arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.main[0].arn
  }

  condition {
    host_header {
      values = [
        var.hostname
      ]
    }
  }
}

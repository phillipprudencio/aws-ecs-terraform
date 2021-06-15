resource "aws_lb_listener_rule" "main" {
  listener_arn = var.loadbalancer_rule_arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.main.arn
  }

  condition {
    host_header {
      values = [
        var.hostname
      ]
    }
  }
}

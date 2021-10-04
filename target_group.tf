resource "aws_lb_target_group" "lb-target-group" {
  name        = "lb-target-group"
  port        = "80"
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200,301,302"
  }
}

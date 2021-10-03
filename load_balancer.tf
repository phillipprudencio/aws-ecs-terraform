resource "aws_lb" "ecs-elb" {
  name               = "ecs-elb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = aws_security_group.lb_sg.id
  subnets            = aws_subnet.public.*.id
 
  tags = {
    Environment = "production"
  }
}
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

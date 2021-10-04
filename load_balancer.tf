resource "aws_lb" "ecs-elb" {
  name               = "ecs-elb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-02041171d46e310ad"]
  subnets               = ["subnet-e5f594be", "subnet-0830be6d"] 

}


resource "aws_lb_listener_rule" "main" {
  count = var.no_loadbalancer ? 0 : 1
  listener_arn = aws_alb_target_group.arn

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

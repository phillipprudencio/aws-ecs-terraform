./ resource "aws_lb" "ecs-elb" {
  name               = "ecs-elb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-02041171d46e310ad"]
  subnets               = ["subnet-e5f594be", "subnet-0830be6d"] 

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

./
  resource "aws_lb" "ecs-elb" {
  name               = "ecs-elb"
  load_balancer_type = "application"
  internal           = false
  subnets            = ["subnet-e5f594be", "subnet-0830be6d"]
  tags = {
    "env"       = "dev"
    "createdBy" = "mkerimova"
  }
  security_groups = [aws_security_group.lb.id]
}
resource "aws_security_group" "lb" {
  name   = "allow-all-lb"
  vpc_id = "vpc-aafc48cc"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "env"       = "dev"
    "createdBy" = "mkerimova"
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


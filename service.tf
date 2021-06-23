resource "aws_ecs_service" "main" {
  name            = var.name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = var.autoscaling_min_capacity
  launch_type     = "FARGATE"
  tags            = var.tags

  network_configuration {
    security_groups  = [aws_security_group.ecs.id]
    subnets          = var.subnets
    assign_public_ip = true
  }

  dynamic "load_balancer" {
    for_each = var.no_loadbalancer ? [] : [1]
    content {
      target_group_arn = aws_alb_target_group.main[0].id
      container_name   = var.name
      container_port   = var.task_port
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.ecs_task_execution_role
  ]
}

resource "aws_appautoscaling_target" "main" {
  max_capacity       = var.autoscaling_max_capacity
  min_capacity       = var.autoscaling_min_capacity
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.main.name}"
  role_arn           = "arn:aws:iam::${local.account_id}:role/ecsAutoscaleRole"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "cpu_policy" {
  name               = "cpu-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.main.resource_id
  scalable_dimension = aws_appautoscaling_target.main.scalable_dimension
  service_namespace  = aws_appautoscaling_target.main.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = var.autoscalling_tracking_cpu_at
  }
}

resource "aws_appautoscaling_policy" "memory_policy" {
  name               = "memory-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.main.resource_id
  scalable_dimension = aws_appautoscaling_target.main.scalable_dimension
  service_namespace  = aws_appautoscaling_target.main.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value = var.autoscalling_tracking_memory_at
  }
}
resource "aws_ecs_service" "ecs_service" {
  name            = "devops-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_def.arn
  desired_count   = 2
  network_configuration {
    subnets         = [var.subnet1, var.subnet2]
    security_groups = [var.ecs_sg_id]
  }

  force_new_deployment = true

  triggers = {
    redeployment = timestamp()
  }

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ecs_capacity_provider.name
    weight            = 100
  }

  load_balancer {
    target_group_arn = var.lb_target_group_arn
    container_name   = "devops-challenge"
    container_port   = 80
  }

}

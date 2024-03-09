output "asg_arn" {
  value = aws_autoscaling_group.ecs_asg.arn
}

output "lb_target_group_arn" {
  value = aws_lb_target_group.ecs_tg.arn
}

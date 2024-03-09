output "subnet1" {
  value = aws_subnet.subnet.id
}

output "subnet2" {
  value = aws_subnet.subnet2.id
}

output "vpc_main_id" {
  value = aws_vpc.main.id
}

output "ecs_sg_id" {
  value = aws_security_group.security_group.id
}

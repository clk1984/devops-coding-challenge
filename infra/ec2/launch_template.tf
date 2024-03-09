data "aws_ami" "ecs_optimized" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_iam_instance_profile" "ecs_profile" {
  name = "ecs_profile"
  role = var.ecs_instace_role_name
}

resource "aws_launch_template" "ecs_lt" {
  name_prefix            = "ecs-template"
  image_id               = data.aws_ami.ecs_optimized.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [var.ecs_sg_id]

  iam_instance_profile {
    name = "ecs_profile"
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 30
      volume_type = "gp2"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ecs-instance"
    }
  }

  user_data = filebase64("${path.module}/ecs.sh")

}

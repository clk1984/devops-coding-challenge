terraform {
  backend "s3" {
    # Terraform doesn't allow backend interpolation. We need to specifiy the bucket in all init commands
    # bucket         = "${var.environment}-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-west-3"
    dynamodb_table = "terraform_locks"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.11.0"
    }
  }
}

provider "aws" {
  region = var.region
}



module "vpc" {
  source = "./vpc"
  region = var.region
}

module "iam" {
  source = "./iam"
}

module "ecr" {
  source      = "./ecr"
  environment = var.environment
}

module "ec2" {
  source                = "./ec2"
  ecs_sg_id             = module.vpc.ecs_sg_id
  subnet1               = module.vpc.subnet1
  subnet2               = module.vpc.subnet2
  vpc_main_id           = module.vpc.vpc_main_id
  ecs_instace_role_name = module.iam.ecs_instace_role_name
  environment           = var.environment
}

module "ecs" {
  depends_on          = [module.ec2]
  source              = "./ecs"
  environment         = var.environment
  asg_arn             = module.ec2.asg_arn
  account_id          = var.account_id
  registry_id         = module.ecr.registry_id
  subnet1             = module.vpc.subnet1
  subnet2             = module.vpc.subnet2
  ecs_sg_id           = module.vpc.ecs_sg_id
  lb_target_group_arn = module.ec2.lb_target_group_arn
}

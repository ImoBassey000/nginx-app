terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.0"
}

provider "aws" {
  region = var.aws_region
}

module "networking" {
  source = "./modules/networking"
}

module "ec2" {
  source        = "./modules/ec2"
  instance_type = var.instance_type
  key_name      = var.key_name
  security_group_ids = [module.networking.security_group_id]
}

module "load_balancer" {
  source             = "./modules/load_balancer"
  security_group_ids = [module.networking.security_group_id]
  subnets            = module.networking.subnet_ids
}

module "database" {
  source          = "./modules/database"
  db_instance     = var.db_instance
  db_username     = var.db_username
  db_password     = var.db_password
  security_groups = [module.networking.security_group_id]
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}

output "load_balancer_dns" {
  value = module.load_balancer.dns
}

output "db_endpoint" {
  value = module.database.db_endpoint
  sensitive = true
}

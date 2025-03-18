
module "vpc" {
  source          = "./modules/vpc"
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

resource "aws_subnet" "public" {
  count  = length(var.public_subnets)
  vpc_id = module.vpc.vpc_id # Use the output from the VPC module
  # other properties...
}


module "security_group" {
  source = "./modules/security-group"
  vpc_id = module.vpc.vpc_id
}


module "key_pair" {
  source     = "./modules/key-pair"
  key_name   = var.key_name
  public_key = var.public_key
}


module "ec2" {
  source         = "./modules/ec2"
  security_group = module.security_group.security_group_id
  key_name       = module.key_pair.key_name
  subnet_id      = module.vpc.public_subnets[0]
  ami            = var.ami
  instance_type  = var.instance_type
}


module "load_balancer" {
  source         = "./modules/load-balancer"
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  security_group = module.security_group.security_group_id
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}


output "load_balancer_dns" {
  value = module.load_balancer.lb_dns_name
}

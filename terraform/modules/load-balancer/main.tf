resource "aws_lb" "load-balancer" {
  name               = "main-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group
  subnets            = var.public_subnets

  tags = {
    Name = "MainLoadBalancer"
  }
}

output "lb_dns_name" {
  value = aws_lb.load-balancer.dns_name
}
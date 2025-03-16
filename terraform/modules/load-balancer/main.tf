resource "aws_lb" "my-load-balancer" {
  name               = "my-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group]
  subnets            = var.public_subnets

  tags = {
    Name = "LoadBalancer"
  }
}

output "lb_dns_name" {
  value = aws_lb.my-load-balancer.dns_name
}

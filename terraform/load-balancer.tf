### Load Balancer Module ###
resource "aws_lb" "app_lb" {
  name               = "app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnets
}

output "dns" {
  value = aws_lb.app_lb.dns_name
}

### RDS Module ###
resource "aws_db_instance" "app_db" {
  identifier           = "app-database"
  allocated_storage    = 20
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t3.micro"
  username           = var.db_username
  password           = var.db_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot = true
  vpc_security_group_ids = var.security_groups
}
output "db_endpoint" {
  value = aws_db_instance.app_db.endpoint
  sensitive = true
}
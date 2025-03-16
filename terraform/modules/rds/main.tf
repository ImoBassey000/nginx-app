resource "aws_db_instance" "my-database" {
  identifier            = var.db_identifier
  engine                = "mysql"
  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  username              = var.db_username
  password              = var.db_password
  db_name               = var.db_name
  multi_az              = false
  storage_type          = "gp2"
  skip_final_snapshot   = true
  tags = {
    Name = "my-database"
  }
  vpc_security_group_ids = var.security_group_ids  # Updated for correct variable
  db_subnet_group_name   = aws_db_subnet_group.main.id
}

resource "aws_db_subnet_group" "main" {
  name       = "my-db-subnet-group"
  subnet_ids = var.subnet_ids  # Updated for correct variable
}

output "db_endpoint" {
  value = aws_db_instance.my-database.endpoint
}

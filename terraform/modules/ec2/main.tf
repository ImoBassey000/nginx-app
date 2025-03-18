resource "aws_instance" "my-ec2-instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.security_group]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  tags = {
    Name = "WebServer"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y ansible
            
            EOF

}

output "public_ip" {
  value = aws_instance.my-ec2-instance.public_ip
}






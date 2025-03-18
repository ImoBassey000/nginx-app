resource "tls_private_key" "private_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "my-key-pair" {
  key_name   = var.key_name
  public_key = tls_private_key.private_key_pair.public_key_openssh
}

output "key_name" {
  value = aws_key_pair.my-key-pair.key_name
}


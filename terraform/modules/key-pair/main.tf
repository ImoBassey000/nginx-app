resource "tls_private_key" "private_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "my-key-pair" {
  key_name   = var.key_name
  public_key = tls_private_key.private_key_pair.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.private_key_pair.private_key_pem
  filename = "${path.module}/private_key.pem"
  file_permission = "0600"
}

output "key_name" {
  value = aws_key_pair.my-key-pair.key_name
}

output "private_key_path" {
  value = local_file.private_key.filename
  sensitive = true
}

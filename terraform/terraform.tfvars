vpc_cidr      = "172.31.0.0/16"
ami           = "ami-06cff85354b67982b"
instance_type = "t2.micro"
key_name      = "my-key-pair"
public_key    = "aws_key_pair.my-key-pair"
db_username   = "admin"
db_password   = "supersecretpassword"
public_subnets = [
  "172.31.5.0/24",
  "172.31.10.0/24"
]

private_subnets = [
  "172.31.15.0/24",
  "172.31.20.0/24"
]

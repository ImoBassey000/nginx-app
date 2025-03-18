resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "PublicRouteTable"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id 
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.private_subnets[count.index]
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "Private Subnet ${count.index + 1}"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id  

  tags = {
    Name = "InternetGateway"
  }
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}

data "aws_availability_zones" "available" {}

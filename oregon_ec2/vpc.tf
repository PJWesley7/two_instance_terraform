resource "aws_vpc" "oregon_vpc" {
    cidr_block = var.default_cidr
    tags = {
      "Name" = "oregon_vpc"
    }
}

resource "aws_internet_gateway" "aws_oregon_internet" {
  vpc_id = aws_vpc.oregon_vpc.id
  depends_on = [
    aws_vpc.oregon_vpc
  ]
  tags = {
    "Name" = "oregon_internet"
  }
}

resource "aws_subnet" "aws_oregon_subnet" {
  count = length(var.default_subnets)
  vpc_id = aws_vpc.oregon_vpc.id
  cidr_block = var.default_subnets[count.index]
  availability_zone = var.default_availability_zone[count.index]
tags = {
    Name = var.default_subnet_name[count.index]
  }
}

resource "aws_route_table" "aws_internet-route" {
  vpc_id = aws_vpc.oregon_vpc.id
  depends_on = [
    aws_internet_gateway.aws_oregon_internet
  ]
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.aws_oregon_internet.id
  }
}

resource "aws_route_table_association" "subnet_association" {
  route_table_id = aws_route_table.aws_internet-route.id
  subnet_id = aws_subnet.aws_oregon_subnet[0].id
}

resource "aws_security_group" "oregon_security" {
  vpc_id = aws_vpc.oregon_vpc.id
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

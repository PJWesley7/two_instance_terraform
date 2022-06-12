resource "aws_vpc" "vpc" {
  cidr_block = var.aws_cidr
  tags = {
      Name = "aws_vpc_mumbai"
  }
}

resource "aws_subnet" "subnet" {
  count = length(var.aws_subnet_cidr)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.aws_subnet_cidr[count.index]
  availability_zone = var.aws_subnet_az[count.index]

  tags = {
    Name = var.aws_subnet_names[count.index]
  }
}

resource "aws_internet_gateway" "mumbai_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "mumbai_igw"
  }
}

resource "aws_security_group" "mumbai_security" {
  vpc_id = aws_vpc.vpc.id
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
    ingress {
      from_port = 80
      to_port = 80
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

resource "aws_route_table" "mumbai_route" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mumbai_igw.id
  }
}

resource "aws_route_table_association" "name" {
  subnet_id = aws_subnet.subnet[0].id
  route_table_id = aws_route_table.mumbai_route.id
}

variable "aws_cidr" {
  default = "20.0.0.0/16"
  type = string
}

variable "aws_subnet_cidr" {
  default = ["20.0.0.0/24", "20.0.1.0/24", "20.0.2.0/24"]
  type = list
}

variable "aws_subnet_az" {
  default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  type = list
}

variable "aws_subnet_names" {
  default = ["aws_vpc_mumbai_a", "aws_vpc_mumbai_b", "aws_vpc_mumbai_c"]
  type = list
}
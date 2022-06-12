variable "default_cidr" {
  default = "192.168.0.0/16"
  type = string
}

variable "default_subnets" {
  default = ["192.168.0.0/24", "192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
  type = list
}

variable "default_subnet_name" {
  default = ["aws_oregon_a", "aws_oregon_b", "aws_oregon_c", "aws_oregon_d"]
  type = list
}

variable "default_availability_zone" {
  default = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"]
}
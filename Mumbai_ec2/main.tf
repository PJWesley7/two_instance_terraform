terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

provider "aws"{
  alias = "oregon"
  region = "us-west-2"
}

resource "aws_vpc" "oregon_vpc" {
  provider = aws.oregon
  cidr_block = "192.168.0.0/16"
  tags = {
      Name = "aws_vpc_mumbai"
  }
}

resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = aws_vpc.vpc.id
  peer_vpc_id   = aws_vpc.oregon_vpc.id
  peer_region   = "us-west-2"
  auto_accept   = false

  tags = {
    Side = "Requester"
  }
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  provider = aws.oregon
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}
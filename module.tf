provider "aws"{
  region = "ap-south-1"
}

provider "aws"{
  alias = "oregon"
  region = "us-west-2"
}

module "mumbai_ec2" {
    source = "./Mumbai_ec2"
}

module "oregon_ec2" {
  source = "./oregon_ec2"
}

resource "aws_instance" "mumbai-ec2" {
  ami = "ami-0675118d2eaeabbc7"
  instance_type = "t2.micro" 
  key_name = "learning"
  vpc_security_group_ids = [aws_security_group.mumbai_security.id]
  associate_public_ip_address = true
  subnet_id = aws_subnet.subnet[0].id
}


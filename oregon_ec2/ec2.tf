resource "aws_instance" "oregon_instance" {
  ami           = "ami-0cb4e786f15603b0d"
  associate_public_ip_address = true
  instance_type = "t2.micro"
  key_name = "learning_oregon"
  vpc_security_group_ids = [aws_security_group.oregon_security.id]
  subnet_id = aws_subnet.aws_oregon_subnet[0].id
  tags = {
    Name = "Oregon_instance"
  }
}
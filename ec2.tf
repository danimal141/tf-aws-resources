resource "aws_instance" "sample_instance" {
  ami = "ami-785c491f" # Ubuntu 16.04 LTS official ami
  vpc_security_group_ids = [aws_security_group.ec2_ins_security_group.id]
  subnet_id = aws_subnet.sample_public_subnet1.id
  key_name = aws_key_pair.sample_key_pair.id
  instance_type = "t2.micro"
  associate_public_ip_address = "true"

  tags = {
    Name = "sample_instance"
  }
}

resource "aws_key_pair" "sample_key_pair" {
  key_name = var.key_name
  public_key = file(var.public_key_path)
}

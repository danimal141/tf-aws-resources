resource "aws_vpc" "sample_vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags =  {
    Name = "sample_vpc"
  }
}

resource "aws_subnet" "sample_public_subnet1" {
  vpc_id = aws_vpc.sample_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags =  {
    Name = "sample_public_subnet1"
  }
}

resource "aws_subnet" "sample_private_subnet1" {
  vpc_id = aws_vpc.sample_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "sample_private_subnet1"
  }
}

resource "aws_internet_gateway" "sample_igw" {
  vpc_id = aws_vpc.sample_vpc.id

  tags = {
    Name = "sample_igw"
  }
}

resource "aws_route_table" "sample_route_table" {
  vpc_id = aws_vpc.sample_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sample_igw.id
  }

  tags = {
    Name = "sample_route_table"
  }
}

resource "aws_route_table_association" "sample_public_subnet1" {
  subnet_id = aws_subnet.sample_public_subnet1.id
  route_table_id = aws_route_table.sample_route_table.id
}

resource "aws_security_group" "ec2_ins_security_group" {
  vpc_id = aws_vpc.sample_vpc.id

  tags = {
    Name = "ec2_ins_security_group"
  }
}

resource "aws_security_group_rule" "in_ssh" {
  security_group_id = aws_security_group.ec2_ins_security_group.id
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
  from_port = 22
  to_port = 22
  protocol = "tcp"
}

resource "aws_security_group_rule" "out_all" {
  security_group_id = aws_security_group.ec2_ins_security_group.id
  type = "egress"
  cidr_blocks = ["0.0.0.0/0"]
  from_port = 0
  to_port = 0
  protocol = "-1"
}

provider "aws" {
  region  = "us-east-1"
  version = "~> 2.1"
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "awsmeetup-vpc"
    Environment = "awsmeetup"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name        = "awsmeetup-subnet"
    Environment = "awsmeetup"
  }
}

resource "aws_key_pair" "demokey" {
  key_name   = "demo-key"
  public_key = "${var.ssh_key}"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0a313d6098716f372"            # Current Canonical Bionic 18.04 image
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.demokey.key_name}"

  security_groups = ["${aws_security_group.allow_ssh.id}"]
  subnet_id       = "${aws_subnet.main.id}"

  tags = {
    Name        = "awsmeetup-ec2-web"
    Environment = "awsmeetup"
  }
}

resource "aws_eip" "webip" {
  instance = "${aws_instance.web.id}"
  vpc      = true
}

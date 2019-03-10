provider "aws" {
  region  = "us-east-1"
  version = "~> 2.1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

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

resource "aws_instance" "web" {
  ami           = "ami-0a313d6098716f372" # Current Canonical Bionic 18.04 image
  instance_type = "t2.micro"

  vpc_security_group_ids = ["${aws_vpc.main.default_security_group_id}"]
  subnet_id              = "${aws_subnet.main.id}"

  tags = {
    Name        = "awsmeetup-ec2-web"
    Environment = "awsmeetup"
  }
}

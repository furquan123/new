provider "aws" {
region = "ap-south-1"
access_key = "AKIAWDHXRCZ4XXHASQ5C"
secret_key = "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"
}

resource "aws_instance" "one" {
  ami             = "ami-067c21fb1979f0b27"
  instance_type   = "t2.medium"
  key_name        = "devops"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "ap-south-1a"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my app created by terraform infrastructurte by furkhan server-1" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-1"
  }
}

resource "aws_instance" "two" {
  ami             = "ami-067c21fb1979f0b27"
  instance_type   = "t2.micro"
  key_name        = "devops"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "ap-south-1a"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my website created by terraform infrastructurte by  sir furkhannserver-2" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-2"
  }
}

resource "aws_instance" "three" {
  ami             = "ami-067c21fb1979f0b27"
  instance_type   = "t2.large"
  key_name        = "devops"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "ap-south-1a"
  tags = {
    Name = "app-server-1"
  }
}

resource "aws_instance" "four" {
  ami             = "ami-067c21fb1979f0b27"
  instance_type   = "t2.large"
  key_name        = "devops"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "ap-south-1a"
  tags = {
    Name = "app-server-2"
  }
}

resource "aws_security_group" "five" {
  name = "nouman-elb"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "six" {
  bucket = "nouman"
}

resource "aws_ebs_volume" "eight" {
 availability_zone = "ap-south-1a"
  size = 20
  tags = {
    Name = "nouman-ebs"
  }
}

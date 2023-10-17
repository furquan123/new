provider "aws" {
region = "ap-south-1"
access_key = "AKIAWDHXRCZ4SQATWKDA"
secret_key = "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"
}

resource "aws_instance" "one" {
  ami             = "ami-0b41f7055516b991a"
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
echo "hai all this is my app created by terraform infrastructurte by furkhan server-1" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-1"
  }
}

resource "aws_instance" "two" {
  ami             = "ami-0b41f7055516b991a"
  instance_type   = "t2.large"
  key_name        = "devops"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "ap-south-1a"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my website created by terraform infrastructurte by  sir furkhan server-2" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-2"
  }
}

resource "aws_instance" "three" {
  ami             = "ami-0b41f7055516b991a"
  instance_type   = "t2.small"
  key_name        = "devops"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "ap-south-1a"
  tags = {
    Name = "app-server-1"
  }
}

resource "aws_instance" "four" {
  ami             = "ami-0b41f7055516b991a"
  instance_type   = "t2.medium"
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
  bucket = "furkhans"
}

resource "aws_ebs_volume" "eight" {
 availability_zone = "ap-south-1a"
  size = 25
  tags = {
    Name = "naseem-ebs"
  }
}

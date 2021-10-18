resource "aws_instance" "jenkins" {
  ami = "ami-0ab4d1e9cf9a1215a"
  instance_type = "t2.micro"
  security_groups = "${aws_security_group.allow_tls.id}"
  tags = {
    Name = "jenkins-server"
  }
  key_name = "ec2-user"
}

resource "aws_key_pair" "jenkins" {
  key_name = "ec2-user"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCU3FvpHEwefi2nJsWRKnnFRVAkLOPyCqRb8F7QzoVqVm8Bfe8kHzeIVdfmEeuO6SfM51MjDxY5tse3AE0S5Sb7nG6GnHuLQXOjd6IN1iHmB1tMC9Sg0vymtgGqSuPr9Y5RBRGMt9bPgT3aOCDs26WHUOquZ0teYpip0wDiKKJbKinY++tm+KH7r5VBrLVv5G5Iqt/MOb0WPKJz2UFP+Uc3AUAzC7B2k8GAQexVAgksHER9Xc6JgXGjfaeErDMUcp0gNKeGoHCjEXHdZjHuNmoohyK63EWU+mWkIybp2o6mREapMzhQzDLxge8zA6RSwhWXXmPhzYo89Gyn4GjrI5px ec2-user"
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
      description      = "TLS from VPC"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.main.cidr_block]
    }

    ingress {
      description      = "http from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.main.cidr_block]
    }

    ingress {
      description      = "https from VPC"
      from_port        = 8080
      to_port          = 8080
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.main.cidr_block]
    }

    ingress {
      description      = "ssh from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.main.cidr_block]
    }

    ingress {
      description      = "ICMP from VPC"
      from_port        = -1
      to_port          = -1
      protocol         = "icmp"
      cidr_blocks      = [aws_vpc.main.cidr_block]
    }
  

  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  tags = {
    Name = "allow_tls_ssh_http(s)"
  }
}
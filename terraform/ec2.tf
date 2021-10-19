resource "aws_instance" "jenkins" {
  ami = "ami-0ab4d1e9cf9a1215a"
  instance_type = "t2.micro"
  security_groups = ["sg_WebServer"]
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
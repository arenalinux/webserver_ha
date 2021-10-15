resource "aws_instance" "jenkins" {
  ami = "ami-0ab4d1e9cf9a1215a"
  instance_type = "t2.micro"
  tags = {
    Name = "jenkins-server"
  }
  key_name = "ec2-user"
}

resource "aws_key_pair" "jenkins" {
  key_name = "ec2-user"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsBiOWy0KeqcxYe9qwgYNUxZc3VffxuYNW8/HwE63ebuc0c4O0kFL4lsXBkLJQI1nVzMQC1713Vud8CkgLPCJ8vZ61gY+DCgxSB8G95LU+znioHDz9GLdmFFGKv9SXHOlx510S/2sqe+jncV8ACVleFxZH+XBnmZs2iObV47U+0+IT9ZcpY9sODm8nsV4RQKylXTFZsiilKxdZMkd63EnadstoVFI3q7uTN7wAd1OrEQltS8zijhMgAoRK9b1L8zslC18tlamy5DJLsCs+UlZfuT2pMXDglrfN567w+uH2NoXvUIKpFezb9zkMCxg+BLg9PJY1GzJnFNIAmC5ok2kv ec2-user"
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress = [
    {
      description      = "TLS from VPC"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.main.cidr_block]
      ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }
    {
      description      = "http from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.main.cidr_block]
      ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }
    {
      description      = "https from VPC"
      from_port        = 8080
      to_port          = 8080
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.main.cidr_block]
      ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }
    {
      description      = "ssh from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.main.cidr_block]
      ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }
    {
      description      = "ICMP from VPC"
      from_port        = -1
      to_port          = -1
      protocol         = "icmp"
      cidr_blocks      = [aws_vpc.main.cidr_block]
      ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]

  tags = {
    Name = "allow_tls_ssh_http(s)"
  }
}
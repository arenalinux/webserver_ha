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
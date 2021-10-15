output "dns_name" {
	value = aws_instance.jenkins.public_dns
}
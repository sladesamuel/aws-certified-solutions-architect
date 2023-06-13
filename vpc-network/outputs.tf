output "public_ec2_ip" {
  description = "The public IPv4 assigned to the public EC2 instance"
  value       = aws_instance.webserver.public_ip
}

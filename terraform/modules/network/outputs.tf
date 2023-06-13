output "vpc_id" {
  description = "The Id of the VPC"
  value       = aws_vpc.network.id
}

output "public_subnet_a" {
  description = "The Id of Public Subnet A"
  value       = module.public_subnet_a.subnet_id
}

output "public_subnet_b" {
  description = "The Id of Public Subnet B"
  value       = module.public_subnet_b.subnet_id
}

output "private_subnet_a" {
  description = "The Id of Private Subnet A"
  value       = module.private_subnet_a.subnet_id
}

output "private_subnet_b" {
  description = "The Id of Private Subnet B"
  value       = module.private_subnet_b.subnet_id
}

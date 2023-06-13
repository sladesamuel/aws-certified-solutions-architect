output "subnet_id" {
  description = "The Id of the Subnet created by this module"
  value       = aws_subnet.this.id
}

output "nat_gateway_id" {
  description = "The Id of the NAT Gateway created by this module if the Subnet is public, otherwise null"
  value       = length(aws_nat_gateway.this) > 0 ? aws_nat_gateway.this[0].id : null
}

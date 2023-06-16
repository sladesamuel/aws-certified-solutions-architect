output "subnet_id" {
  description = "The Id of the Subnet"
  value       = aws_subnet.this.id
}

output "nat_gateway_id" {
  description = "The Id of the NAT Gateway created by this module"
  value       = aws_nat_gateway.this.id
}

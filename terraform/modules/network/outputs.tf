output "vpc_id" {
  description = "The Id of the VPC"
  value       = aws_vpc.network.id
}

output "public_subnets" {
  description = "The Ids of the public Subnets"

  value = {
    subnet_a = module.public_subnet_a.subnet_id
    subnet_b = module.public_subnet_b.subnet_id
  }
}

output "app_subnets" {
  description = "The Ids of the private Subnets provisioned for the application servers"

  value = {
    subnet_a = module.app_subnet_a.subnet_id
    subnet_b = module.app_subnet_b.subnet_id
  }
}

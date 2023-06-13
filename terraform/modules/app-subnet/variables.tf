variable "vpc_id" {
  description = "The Id of the VPC the Subnet is part of"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block to assign to the Subnet"
  type        = string
}

variable "nat_gateway_id" {
  description = "The Id of the NAT Gateway to route traffic to from this Subnet"
  type        = string
}

variable "availability_zone" {
  description = "The name of the Availability Zone within the current Region in which to provision the subnet"
  type        = string
}

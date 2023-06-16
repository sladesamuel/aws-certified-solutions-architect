variable "vpc_id" {
  description = "The Id of the VPC the Subnet is part of"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block to assign to the Subnet"
  type        = string
}

variable "availability_zone" {
  description = "The name of the Availability Zone within the current Region in which to provision the subnet"
  type        = string
}

variable "internet_gateway_id" {
  description = "The Id of the Internet Gateway to route traffic to from this Subnet"
  type        = string
}

variable "route_table_id" {
  description = "The Id of the Route Table to use for routing traffic from this Subnet to the Internet Gateway"
  type        = string
}

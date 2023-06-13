variable "name" {
  description = "The name of the Subnet"
  type        = string
}

variable "vpc_id" {
  description = "The Id of the VPC the Subnet is part of"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block to assign to the Subnet"
  type        = string
}

variable "internet_gateway_id" {
  description = "The Id of the Internet Gateway to route traffic to from this Subnet"
  type        = string
  default     = null
}

variable "nat_gateway_id" {
  description = "The Id of the NAT Gateway to route traffic to from this Subnet"
  type        = string
  default     = null
}

variable "availability_zone" {
  description = "The name of the Availability Zone within the current Region in which to provision the subnet"
  type        = string
}

variable "is_public" {
  description = "Specifies whether this is a public (true) or private (false) Subnet"
  type        = bool
  default     = false
}

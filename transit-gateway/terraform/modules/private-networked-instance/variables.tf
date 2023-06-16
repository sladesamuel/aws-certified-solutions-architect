variable "region" {
  description = "The AWS Region in which to provision the network"
  type        = string
}

variable "name" {
  description = "The name of the network"
  type        = string
}

variable "cidrs" {
  description = "The CIDR blocks to assign to the VPC and contained Subnet"

  type = object({
    vpc    = string
    subnet = string
  })
}

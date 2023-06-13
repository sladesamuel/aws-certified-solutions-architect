resource "aws_vpc" "network" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "slade-lab-network"
  }
}

resource "aws_internet_gateway" "internet" {
  vpc_id = aws_vpc.network.id

  tags = {
    Name = "slade-lab-igw"
  }
}

#############################################################
# Public Subnets
#############################################################
module "public_subnet_a" {
  source = "../subnet"

  name                = "internet"
  vpc_id              = aws_vpc.network.id
  cidr_block          = "10.0.1.0/24"
  internet_gateway_id = aws_internet_gateway.internet.id
  availability_zone   = "eu-west-2a"
  is_public           = true
}

module "public_subnet_b" {
  source = "../subnet"

  name                = "internet"
  vpc_id              = aws_vpc.network.id
  cidr_block          = "10.0.2.0/24"
  internet_gateway_id = aws_internet_gateway.internet.id
  availability_zone   = "eu-west-2b"
  is_public           = true
}

#############################################################
# App Subnets
#############################################################
module "app_subnet_a" {
  source = "../subnet"

  name              = "app"
  vpc_id            = aws_vpc.network.id
  cidr_block        = "10.0.4.0/23"
  nat_gateway_id    = module.public_subnet_a.nat_gateway_id
  availability_zone = "eu-west-2a"
}

module "app_subnet_b" {
  source = "../subnet"

  name              = "app"
  vpc_id            = aws_vpc.network.id
  cidr_block        = "10.0.6.0/23"
  nat_gateway_id    = module.public_subnet_b.nat_gateway_id
  availability_zone = "eu-west-2b"
}

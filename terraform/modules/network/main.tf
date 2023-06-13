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
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.network.id

  tags = {
    Name = "slade-lab-public-routes"
  }
}

module "public_subnet_a" {
  source = "../public-subnet"

  vpc_id              = aws_vpc.network.id
  cidr_block          = "10.0.1.0/24"
  internet_gateway_id = aws_internet_gateway.internet.id
  route_table_id      = aws_route_table.public.id
  availability_zone   = "eu-west-2a"
}

module "public_subnet_b" {
  source = "../public-subnet"

  vpc_id              = aws_vpc.network.id
  cidr_block          = "10.0.2.0/24"
  internet_gateway_id = aws_internet_gateway.internet.id
  route_table_id      = aws_route_table.public.id
  availability_zone   = "eu-west-2b"
}

#############################################################
# App Subnets
#############################################################
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.network.id

  tags = {
    Name = "slade-lab-private-routes"
  }
}

module "app_subnet_a" {
  source = "../app-subnet"

  vpc_id            = aws_vpc.network.id
  cidr_block        = "10.0.4.0/23"
  nat_gateway_id    = module.public_subnet_a.nat_gateway_id
  route_table_id    = aws_route_table.private.id
  availability_zone = "eu-west-2a"
}

module "app_subnet_b" {
  source = "../app-subnet"

  vpc_id            = aws_vpc.network.id
  cidr_block        = "10.0.6.0/23"
  nat_gateway_id    = module.public_subnet_b.nat_gateway_id
  route_table_id    = aws_route_table.private.id
  availability_zone = "eu-west-2b"
}

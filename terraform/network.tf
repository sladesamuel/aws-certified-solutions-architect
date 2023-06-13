resource "aws_vpc" "network" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "${local.prefix}-network"
  }
}

####################################################################
# Public network
####################################################################

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.network.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.prefix}-public-subnet"
  }
}

resource "aws_internet_gateway" "internet" {
  vpc_id = aws_vpc.network.id

  tags = {
    Name = "${local.prefix}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.network.id

  tags = {
    Name = "${local.prefix}-public"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

####################################################################
# Private network
####################################################################

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.network.id
  cidr_block = "10.0.2.0/23"

  tags = {
    Name = "${local.prefix}-private-subnet"
  }
}

resource "aws_eip" "private_ip" {
  tags = {
    Name = "${local.prefix}-private-ip"
  }
}

resource "aws_nat_gateway" "private" {
  subnet_id     = aws_subnet.private.id
  allocation_id = aws_eip.private_ip.allocation_id

  tags = {
    Name = "${local.prefix}-private-nat-gateway"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.network.id

  tags = {
    Name = "${local.prefix}-private"
  }
}

resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.private.id
}

resource "aws_route_table_association" "private" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private.id
}

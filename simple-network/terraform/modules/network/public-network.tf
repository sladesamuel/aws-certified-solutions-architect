resource "aws_route_table" "public" {
  vpc_id = aws_vpc.network.id

  tags = {
    Name = "slade-lab-public-routes"
  }
}

resource "aws_route" "this" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet.id
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

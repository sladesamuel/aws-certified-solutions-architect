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

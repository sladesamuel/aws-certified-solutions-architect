module "app_subnet_a" {
  source = "../app-subnet"

  vpc_id            = aws_vpc.network.id
  cidr_block        = "10.0.4.0/23"
  nat_gateway_id    = module.public_subnet_a.nat_gateway_id
  availability_zone = "eu-west-2a"
}

module "app_subnet_b" {
  source = "../app-subnet"

  vpc_id            = aws_vpc.network.id
  cidr_block        = "10.0.6.0/23"
  nat_gateway_id    = module.public_subnet_b.nat_gateway_id
  availability_zone = "eu-west-2b"
}

module "db_subnet_a" {
  source = "../db-subnet"

  vpc_id            = aws_vpc.network.id
  cidr_block        = "10.0.8.0/23"
  availability_zone = "eu-west-2a"
}

module "db_subnet_b" {
  source = "../db-subnet"

  vpc_id            = aws_vpc.network.id
  cidr_block        = "10.0.10.0/23"
  availability_zone = "eu-west-2b"
}

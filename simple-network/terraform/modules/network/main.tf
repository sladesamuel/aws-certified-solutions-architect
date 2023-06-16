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

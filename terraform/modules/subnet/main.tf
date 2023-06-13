resource "aws_subnet" "this" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block

  tags = {
    Name = "${local.name_prefix}-subnet-${local.name_suffix}"
  }
}

resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${local.name_prefix}-rtb-${local.name_suffix}"
  }
}

resource "aws_route_table_association" "this" {
  route_table_id = aws_route_table.this.id
  subnet_id      = aws_subnet.this.id
}

resource "aws_route" "public" {

  # This is a public route, routing traffic to the Internet Gateway
  # so it is only available when this Subnet is public
  count = var.is_public ? 1 : 0

  route_table_id         = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
}

resource "aws_route" "private" {

  # This is a private route, routing traffic to the NAT Gateway
  # so it is only available when this Subnet is private
  count = var.is_public ? 0 : 1

  route_table_id         = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"

  # Don't use the NAT Gateway created by this module, as that will
  # only be created when the Subnet is public. Instead, we reference
  # a NAT Gateway that exists in a public Subnet from this private Subnet
  nat_gateway_id = var.nat_gateway_id
}



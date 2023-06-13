resource "aws_eip" "this" {

  # The Elastic IP is only required for the NAT Gateway
  count = local.should_create_nat_gateway ? 1 : 0

  tags = {
    Name = "${local.name_prefix}-ip-${local.name_suffix}"
  }
}

resource "aws_nat_gateway" "this" {
  count = local.should_create_nat_gateway ? 1 : 0

  subnet_id     = aws_subnet.this.id
  allocation_id = aws_eip.this[0].allocation_id

  tags = {
    Name = "${local.name_prefix}-ngw-${local.name_suffix}"
  }
}

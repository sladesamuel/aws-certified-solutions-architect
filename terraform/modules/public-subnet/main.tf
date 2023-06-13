resource "aws_subnet" "this" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block

  tags = {
    Name = "slade-lab-public-subnet-${var.availability_zone}"
  }
}

resource "aws_route_table_association" "this" {
  route_table_id = var.route_table_id
  subnet_id      = aws_subnet.this.id
}

resource "aws_eip" "this" {
  tags = {
    Name = "slade-lab-public-subnet-ip-${var.availability_zone}"
  }
}

resource "aws_nat_gateway" "this" {
  subnet_id     = aws_subnet.this.id
  allocation_id = aws_eip.this.allocation_id

  tags = {
    Name = "slade-lab-public-subnet-ngw-${var.availability_zone}"
  }
}

resource "aws_vpc" "network" {
  cidr_block           = var.cidrs.vpc
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.name}-vpc"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.network.id
  availability_zone = "${var.region}a"
  cidr_block        = var.cidrs.subnet

  tags = {
    Name = "${var.name}-subnet"
  }
}

# Enable the VPC Endpoints required for the EC2 Instance to be able to access Session Manager
resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = aws_vpc.network.id
  vpc_endpoint_type = "Interface"
  service_name      = "com.amazonaws.${var.region}.ssm"

  subnet_ids = [aws_subnet.subnet.id]

  tags = {
    Name = "${var.name}-vpc-endpoint-ssm"
  }
}

resource "aws_vpc_endpoint" "ssm_messages" {
  vpc_id            = aws_vpc.network.id
  vpc_endpoint_type = "Interface"
  service_name      = "com.amazonaws.${var.region}.ssmmessages"

  subnet_ids = [aws_subnet.subnet.id]

  tags = {
    Name = "${var.name}-vpc-endpoint-ssmmessages"
  }
}

resource "aws_vpc_endpoint" "ec2_messages" {
  vpc_id            = aws_vpc.network.id
  vpc_endpoint_type = "Interface"
  service_name      = "com.amazonaws.${var.region}.ec2messages"

  subnet_ids = [aws_subnet.subnet.id]

  tags = {
    Name = "${var.name}-vpc-endpoint-ec2messages"
  }
}

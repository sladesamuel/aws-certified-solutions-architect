resource "aws_security_group" "instance" {
  name        = "${var.name}-sg"
  description = "Allows inbound ICMP traffic to the EC2 Instance and all outbound traffic"
  vpc_id      = aws_vpc.network.id

  ingress {
    description = "Allow inbound ICMP traffic"
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "icmp"
    from_port   = 0
    to_port     = 0
  }

  egress {
    description = "Allow all outbound traffic"
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = -1
    from_port   = 0
    to_port     = 0
  }

  tags = {
    Name = "${var.name}-sg"
  }
}

resource "aws_instance" "instance" {
  ami                    = "ami-07650ecb0de9bd731"
  instance_type          = "t2.micro"
  availability_zone      = data.aws_availability_zone.az.name
  iam_instance_profile   = aws_iam_instance_profile.instance.name
  vpc_security_group_ids = [aws_security_group.instance.id]
  subnet_id              = aws_subnet.subnet.id

  tags = {
    Name = "${var.name}-ec2"
  }
}

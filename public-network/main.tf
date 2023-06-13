resource "aws_security_group" "webserver_firewall" {
  name        = "${local.prefix}-webserver-firewall"
  description = "Allow inbound HTTP access to the webserver"
  vpc_id      = aws_vpc.network.id

  ingress {
    description = "Allow inbound on port 80 (HTTP)"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"] # Allow access from anywhere
  }

  egress {
    description = "Allow all outbound traffic"
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.prefix}-webserver-firewall"
  }
}

resource "aws_instance" "webserver" {
  # Amazon Linux 2023 AMI 2023.0.20230607.0 x86_64 HVM kernel-6.1
  ami                    = "ami-02fb3e77af3bea031"
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_instance_profile.webserver.name
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.webserver_firewall.id]
  user_data              = file("${path.module}/data/ec2-public-instance.sh")

  tags = {
    Name = "${local.prefix}-webserver"
  }
}

module "network" {
  source = "./modules/network"
}

resource "aws_security_group" "load_balancer" {
  name   = "${local.prefix}-alb-sg"
  vpc_id = module.network.vpc_id

  ingress {
    description = "Allow inbound HTTP traffic"
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
  }

  egress {
    description = "Allow all outbound traffic"
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = -1
    from_port   = 0
    to_port     = 0
  }

  tags = {
    Name = "${local.prefix}-alb-sg"
  }
}

resource "aws_lb" "app" {
  name               = "${local.prefix}-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load_balancer.id]

  subnets = [
    module.network.app_subnets.subnet_a,
    module.network.app_subnets.subnet_b
  ]

  tags = {
    Name = "${local.prefix}-alb"
  }
}

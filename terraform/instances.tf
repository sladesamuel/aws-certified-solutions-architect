resource "aws_security_group" "app_server" {
  name   = "${local.prefix}-app-server-sg"
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
    Name = "${local.prefix}-app-server-sg"
  }
}

resource "aws_launch_template" "app_server" {
  name = "${local.prefix}-app-server-launch-template"

  iam_instance_profile {
    name = aws_iam_instance_profile.app_server.name
  }

  image_id      = local.ec2_ami
  instance_type = "t2.micro"

  vpc_security_group_ids = [
    aws_security_group.app_server.id
  ]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${local.prefix}-app-server"
    }
  }
}

resource "aws_autoscaling_group" "app_server" {
  name = "${local.prefix}-app-server-asg"

  desired_capacity = 4
  min_size         = 2
  max_size         = 8

  launch_template {
    id      = aws_launch_template.app_server.id
    version = "$Latest"
  }

  vpc_zone_identifier = [
    module.network.app_subnets.subnet_a,
    module.network.app_subnets.subnet_b
  ]
}

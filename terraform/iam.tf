data "aws_iam_policy_document" "app_server_assume" {
  version = "2012-10-17"

  statement {
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "app_server" {
  name               = "${local.prefix}-app-server"
  description        = "Setup to allow the webserver to be connected to via SSM"
  assume_role_policy = data.aws_iam_policy_document.app_server_assume.json

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]

  tags = {
    Name = "${local.prefix}-app-server"
  }
}

resource "aws_iam_instance_profile" "app_server" {
  name = "${local.prefix}-app-server"
  role = aws_iam_role.app_server.name
}

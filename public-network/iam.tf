data "aws_iam_policy_document" "webserver_assume" {
  version = "2012-10-17"

  statement {
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "webserver" {
  name               = "${local.prefix}-webserver"
  description        = "Setup to allow the webserver to be connected to via SSM"
  assume_role_policy = data.aws_iam_policy_document.webserver_assume.json

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]

  tags = {
    Name = "${local.prefix}-webserver"
  }
}

resource "aws_iam_instance_profile" "webserver" {
  name = "${local.prefix}-webserver"
  role = aws_iam_role.webserver.name
}

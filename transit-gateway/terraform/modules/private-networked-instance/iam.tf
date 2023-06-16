data "aws_iam_policy_document" "assume_role" {
  version = "2012-10-17"

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "instance" {
  name               = "${var.name}-ec2-instance-role"
  description        = "Allows the EC2 Instance to communicate with AWS Systems Manager Session Manager"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]

  tags = {
    Name = "${var.name}-ec2-instance-role"
  }
}

resource "aws_iam_instance_profile" "instance" {
  name = "${var.name}-ec2-instance-profile"
  role = aws_iam_role.instance.name

  tags = {
    Name = "${var.name}-ec2-instance-profile"
  }
}

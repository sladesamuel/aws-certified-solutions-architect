# ####################################################################
# # Public instance
# ####################################################################

# resource "aws_security_group" "webserver_firewall" {
#   name        = "${local.prefix}-webserver-firewall"
#   description = "Allow inbound HTTP access to the webserver"
#   vpc_id      = aws_vpc.network.id

#   ingress {
#     description = "Allow inbound on port 80 (HTTP)"
#     protocol    = "tcp"
#     from_port   = 80
#     to_port     = 80
#     cidr_blocks = ["0.0.0.0/0"] # Allow access from anywhere
#   }

#   egress {
#     description = "Allow all outbound traffic"
#     protocol    = -1
#     from_port   = 0
#     to_port     = 0
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "${local.prefix}-webserver-firewall"
#   }
# }

# resource "aws_instance" "webserver" {
#   ami                    = local.ec2_ami
#   instance_type          = "t2.micro"
#   iam_instance_profile   = aws_iam_instance_profile.webserver.name
#   subnet_id              = aws_subnet.public.id
#   vpc_security_group_ids = [aws_security_group.webserver_firewall.id]
#   user_data              = file("${path.module}/data/ec2-public-instance.sh")

#   tags = {
#     Name = "${local.prefix}-webserver"
#   }
# }

# ####################################################################
# # Private instance
# ####################################################################

# resource "aws_security_group" "private_instance" {
#   name        = "${local.prefix}-private-instance"
#   description = "Allows incoming traffic to private instance from the webserver"
#   vpc_id      = aws_vpc.network.id

#   ingress {
#     description     = "Allow inbound traffic from the webserver security group"
#     security_groups = [aws_security_group.webserver_firewall.id]
#     protocol        = "tcp"
#     from_port       = 80
#     to_port         = 80
#   }

#   egress {
#     description = "Allow all outbound traffic"
#     protocol    = -1
#     from_port   = 0
#     to_port     = 0
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "${local.prefix}-private-sg"
#   }
# }

# resource "aws_instance" "private" {
#   ami                    = local.ec2_ami
#   instance_type          = "t2.micro"
#   iam_instance_profile   = aws_iam_instance_profile.webserver.name
#   subnet_id              = aws_subnet.private.id
#   vpc_security_group_ids = [aws_security_group.private_instance.id]

#   tags = {
#     Name = "${local.prefix}-private-instance"
#   }
# }

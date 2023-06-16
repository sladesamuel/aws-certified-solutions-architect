data "aws_availability_zone" "az" {
  name = "${var.region}a"
}

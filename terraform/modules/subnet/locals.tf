locals {
  public_or_private = var.is_public ? "public" : "private"
  name_prefix       = "slade-lab-${local.public_or_private}-${var.name}"
  name_suffix       = var.availability_zone

  # The NAT Gateway should be created by the public Subnet
  # and consumed by the private Subnet
  should_create_nat_gateway = var.is_public
}

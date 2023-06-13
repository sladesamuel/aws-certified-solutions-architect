locals {
  is_public         = var.internet_gateway_id != null
  public_or_private = local.is_public ? "public" : "private"
  name_prefix       = "slade-lab-${local.public_or_private}"
  name_suffix       = var.availability_zone

  # The NAT Gateway should be created by the public Subnet
  # and consumed by the private Subnet
  should_create_nat_gateway = var.is_public
}

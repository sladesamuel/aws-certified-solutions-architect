module "network" {
  source = "./modules/network"
}

resource "aws_efs_file_system" "app" {
  creation_token = "slade-lab-shared-efs"

  tags = {
    Name = "slade-lab-shared-efs"
  }
}

resource "aws_efs_mount_target" "app_subnet_a" {
  file_system_id = aws_efs_file_system.app.id
  subnet_id      = module.network.app_subnets.subnet_a
}

resource "aws_efs_mount_target" "app_subnet_b" {
  file_system_id = aws_efs_file_system.app.id
  subnet_id      = module.network.app_subnets.subnet_b
}

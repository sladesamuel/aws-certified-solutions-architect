module "network_a" {
  source = "./modules/private-networked-instance"

  region = "eu-west-2"
  name   = "slade-lab-a"

  cidrs = {
    vpc    = "10.0.0.0/16"
    subnet = "10.0.1.0/24"
  }
}

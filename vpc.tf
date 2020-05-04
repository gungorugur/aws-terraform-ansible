module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.33.0"

  name = var.vpc.name
  cidr = var.vpc.cidr

  azs             = var.vpc.availability_zone_names
  public_subnets  = var.vpc.public_subnets
  private_subnets = var.vpc.private_subnets

  enable_nat_gateway = true
}
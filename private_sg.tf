module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.8.0"

  name        = "private-sg"
  description = "Private security group"
  vpc_id      = module.vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      from_port                = 1024
      to_port                  = 65535
      protocol                 = "tcp"
      source_security_group_id = module.public_sg.this_security_group_id
    },
    {
      rule                     = "ssh-tcp"
      source_security_group_id = module.public_sg.this_security_group_id
    }
  ]

  egress_with_cidr_blocks = [
    {
      rule        = "https-443-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}
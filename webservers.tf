resource "aws_instance" "webservers" {
  count                  = 3
  ami                    = var.instance.ami
  instance_type          = var.instance.instance_type
  vpc_security_group_ids = [module.private_sg.this_security_group_id]
  subnet_id              = module.vpc.private_subnets[0]
  key_name               = module.key_pair.this_key_pair_key_name

  tags = {
    Name = "webserver-${count.index + 1}"
  }
}
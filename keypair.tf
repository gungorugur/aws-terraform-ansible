resource "tls_private_key" "key" {
  algorithm = "RSA"
}

module "key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "0.4.0"

  key_name   = "deployer-admin"
  public_key = tls_private_key.key.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.key.private_key_pem
  filename        = "${path.module}/keys/private_key.pem"
  file_permission = "0400"
}

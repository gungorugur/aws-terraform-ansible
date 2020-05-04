module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "5.4.0"

  name               = var.alb.name
  load_balancer_type = var.alb.load_balancer_type

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = [module.public_sg.this_security_group_id]

  target_groups = [
    {
      name             = "webservers-lb-tg"
      backend_protocol = "HTTP"
      backend_port     = 8080
      target_type      = "instance"
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
}

resource "aws_lb_target_group_attachment" "webservers" {
  count            = length(aws_instance.webservers)
  target_group_arn = module.alb.target_group_arns[0]
  target_id        = aws_instance.webservers[count.index].id
  port             = 8080
}
variable "region" {
  type    = string
  default = "us-east-1"
}

variable "instance" {
  type = object({
    ami           = string
    instance_type = string
  })
  default = {
    ami           = "ami-0323c3dd2da7fb37d"
    instance_type = "t2.micro"
  }
}

variable "vpc" {
  type = object({
    name                    = string
    cidr                    = string
    availability_zone_names = list(string)
    public_subnets          = list(string)
    private_subnets         = list(string)
  })
  default = {
    name                    = "web-apps"
    cidr                    = "10.0.0.0/16"
    availability_zone_names = ["us-east-1a", "us-east-1b"]
    public_subnets          = ["10.0.0.0/24", "10.0.1.0/24"]
    private_subnets         = ["10.0.2.0/24"]
  }
}

variable "alb" {
  type = object({
    name               = string
    load_balancer_type = string
  })
  default = {
    name               = "webservers-lb"
    load_balancer_type = "application"
  }
}
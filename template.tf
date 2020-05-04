data template_file "hosts_template" {
  template = file("${path.module}/ansible/_tpl/hosts.tpl")

  vars = {
    webserver = join("\n", aws_instance.webservers.*.private_ip)
  }
}

resource "local_file" "hosts" {
  content  = data.template_file.hosts_template.rendered
  filename = "${path.module}/ansible/hosts"
}

data template_file "all_template" {
  template = file("${path.module}/ansible/_tpl/all.tpl")

  vars = {
    bastion  = aws_instance.bastion.public_ip
    dns_name = module.alb.this_lb_dns_name
  }
}

resource "local_file" "all" {
  content  = data.template_file.all_template.rendered
  filename = "${path.module}/ansible/group_vars/all"
}
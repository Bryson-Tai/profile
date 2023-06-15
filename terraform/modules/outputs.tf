output "aws_instance" {
  value = module.k3s_instance_sg.aws_instance_public_dns
}

output "aws_instance_public_ip" {
  value = module.k3s_instance_sg.aws_instance_public_ip
}


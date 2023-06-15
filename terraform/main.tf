data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_ami" "k3s_ami" {
  dynamic "filter" {
    for_each = { for key, value in var.docker_ami : key => value }

    content {
      name = filter.key
      values = [filter.value]
    }
  }
}

data "aws_key_pair" "aws_wsl_key_pair" {
  dynamic "filter" {
    for_each = { for key, value in var.aws_wsl_key_pair : key => value }

    content {
      name = filter.key
      values = [filter.value]
    }
  }
}

resource "aws_instance" "free_tier_instance" {
  ami           = data.aws_ami.k3s_ami.id
  instance_type = var.aws_instance.instance_type
  key_name      = data.aws_key_pair.aws_wsl_key_pair.key_name

  #? Use this attribute to attach the security group to instance if the security groups is under the VPC
  vpc_security_group_ids = [aws_security_group.sec_group.id]
  tags                   = var.aws_instance.tags

  user_data = file("./install_k3s.sh")

  depends_on = [aws_security_group.sec_group]
}

resource "null_resource" "download_config" {
  triggers = {
    instance_dns = aws_instance.free_tier_instance.public_dns
  }

  provisioner "local-exec" {
    command = "./k3s_config.sh ${aws_instance.free_tier_instance.public_dns} ${aws_instance.free_tier_instance.public_ip}"
  }

  depends_on = [ aws_instance.free_tier_instance ]
}

resource "aws_security_group" "sec_group" {
  name        = "Security Group"
  description = "Allow inbound and outbound traffic"
  vpc_id      = data.aws_vpc.vpc.id

  tags = {
    Name = "allow_ssh"
  }
}

#? Security Group Rule for SSH and Ping
resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  to_port           = 22
  from_port         = 22
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sec_group.id
}

resource "aws_security_group_rule" "tcp" {
  type              = "ingress"
  to_port           = 80
  from_port         = 80
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sec_group.id
}

resource "aws_security_group_rule" "k3s_API" {
  type              = "ingress"
  to_port           = 6443
  from_port         = 6443
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sec_group.id
}

resource "aws_security_group_rule" "K3s_metric" {
  type              = "ingress"
  to_port           = 10250
  from_port         = 10250
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sec_group.id
}

resource "aws_security_group_rule" "outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.sec_group.id
}

#! ================ VPC ================

# resource "aws_vpc" "vpc_test" {
#   cidr_block = "172.16.0.0/16"

#   tags = {
#     Name = "wsl_prefix"
#   }
# }

# resource "aws_subnet" "subnet" {
#   vpc_id            = aws_vpc.vpc_test.id
#   cidr_block        = "172.16.0.0/24"
#   availability_zone = "ap-southeast-1a"

#   depends_on = [ aws_internet_gateway.gw ]
# }

# resource "aws_internet_gateway" "gw" {
#   vpc_id = aws_vpc.vpc_test.id
# }

# resource "aws_eip" "my_eip" {
#   vpc      = true
#   instance = aws_instance.free_tier_instance.id

#   tags = {
#     Name = "MyEIP"
#   }

#   depends_on = [ aws_internet_gateway.gw ]
# }

# resource "aws_eip_association" "my_eip_assoc" {
#   instance_id   = aws_instance.free_tier_instance.id
#   allocation_id = aws_eip.my_eip.id
# }

# resource "aws_key_pair" "wsl_key_pair" {
#   key_name   = var.aws_key_pair.key_name
#   public_key = tls_private_key.pem_key.public_key_openssh

#   tags = var.aws_key_pair.tags
# }

#! ================ SSH PEM Key ================

#? Create private and public key for SSH to AWS Instance
# resource "tls_private_key" "pem_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

#? Create local file after generate PEM key for SSH to AWS Intance
# resource "local_file" "pem_private" {
#   filename             = "~/.ssh/wsl_pem_private.pem"
#   content              = tls_private_key.pem_key.private_key_openssh
#   file_permission      = 0400
#   directory_permission = 0400
# }

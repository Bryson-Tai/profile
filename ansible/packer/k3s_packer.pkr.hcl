
source "amazon-ebs" "autogenerated_1" {
  ami_name             = "k3s-instance"
  instance_type        = "t2.micro"
  source_ami           = "ami-0df7a207adb9748c7"
  ssh_keypair_name     = "wsl"
  ssh_private_key_file = "~/.ssh/aws_wsl.pem"
  ssh_username         = "ubuntu"
  tags = {
    content = "k3s"
    owner   = "bryson"
    usage   = "profile"
  }
}

build {
  sources = ["source.amazon-ebs.autogenerated_1"]

  provisioner "ansible" {
    playbook_file = "../playbook/k3s-playbook.yaml"
    use_proxy     = false
  }

}

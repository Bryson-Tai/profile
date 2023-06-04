module "k3s_instance_sg" {
  source = "../"

  aws_instance = {
    ami           = "ami-0df7a207adb9748c7"
    instance_type = "t2.micro"
    tags = {
      Name = "k3s_instance"
    }
  }

  aws_key_pair = {
    key_name   = "wsl_pem_private"

    tags = {
      system = "wsl"
    }
  }
}

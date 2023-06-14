variable "aws_instance" {
  type = object({
    # ami           = string
    instance_type = string
    tags          = map(string)
  })
}

# variable "aws_key_pair" {
#   type = object({
#     key_name = string
#     tags     = map(string)
#   })
# }

variable "vpc_id" {
  type    = string
  default = "vpc-0e27d2347fc7f31c2"
}

variable "aws_wsl_key_pair" {
  type        = map(string)
  description = "Get existing AWS Key Pair with tags"
}

variable "k3s_ami" {
  type        = map(string)
  description = "Get k3s AMI with tags"
}

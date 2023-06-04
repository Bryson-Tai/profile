variable "aws_instance" {
  type = object({
    ami           = string
    instance_type = string
    tags          = map(string)
  })
}

variable "aws_key_pair" {
  type = object({
    key_name = string
    tags     = map(string)
  })
}

variable "vpc_id" {
  type    = string
  default = "vpc-0e27d2347fc7f31c2"
}

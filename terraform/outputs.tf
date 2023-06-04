output "aws_instance" {
  value = aws_instance.free_tier_instance.public_dns
}

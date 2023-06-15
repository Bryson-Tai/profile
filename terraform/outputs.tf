output "aws_instance_public_dns" {
  value = aws_instance.free_tier_instance.public_dns
}

output "aws_instance_public_ip" {
  value = aws_instance.free_tier_instance.public_ip
}

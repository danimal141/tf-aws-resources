output "sample_instance_public_ip" {
  value = aws_instance.sample_instance.public_ip
}

output "sample_instance_public_dns" {
  value = aws_instance.sample_instance.public_dns
}

output "public_ip" {
  value = aws_instance.ec2.public_ip
}

output "elastic_ip" {
  value = aws_eip.eip.public_ip
}
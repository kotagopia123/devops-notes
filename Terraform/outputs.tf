output "instance_public_ip_addr" {
  value = aws_instance.web.public_ip
}

output "instance_state" {
  value = aws_instance.web.instance_state
}
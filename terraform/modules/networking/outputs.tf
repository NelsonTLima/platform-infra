output "subnet_prod_a" {
  value = aws_subnet.prod_a
}

output "sg_ssh" {
  value = aws_security_group.ssh
}

output "sg_web" {
  value = aws_security_group.web
}

output "sg_egress" {
  value = aws_security_group.egress
}

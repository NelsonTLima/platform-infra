output "ansible_inventory" {
  description = "Playbook to the EC2 instance"
  value = <<EOT
all:
  hosts:
    ec2:
      ansible_host: ${aws_instance.ec2.public_ip}
      ansible_user: ${var.ssh_user}
      ansible_ssh_private_key_file: ${var.private_key_path}
      hostname: ${aws_instance.ec2.tags["Name"]}
EOT
}

output "ipv4" {
  description = "Public ipv4 to the EC2 instance"
  value = aws_instance.ec2.public_ip
}

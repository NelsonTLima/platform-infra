resource "aws_key_pair" "default" {
  key_name = var.ssh_user
  public_key = file("${var.private_key_path}.pub")
}

resource "aws_instance" "ec2" {
  ami           = "ami-0779caf41f9ba54f0" # Debian
  instance_type = "t2.micro"
  subnet_id     = var.subnet_prod_a.id
  key_name      = aws_key_pair.default.key_name
  associate_public_ip_address = true
  vpc_security_group_ids = [
    var.sg_ssh.id,
    var.sg_web.id,
    var.sg_egress.id
  ]

  tags = {
    Name = "prod_a.${var.domain}"
    Environment = "prod"
  }
}

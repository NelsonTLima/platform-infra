resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = { Name = "vpc.${var.domain}" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = { Name = "igw.${var.domain}" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_subnet" "prod_a" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = { Name = "sub.prod.a.${var.domain}" }
}

resource "aws_route_table_association" "prod_a_public" {
  subnet_id = aws_subnet.prod_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "ssh" {
  name = "sg.ssh.${var.domain}"
  vpc_id = aws_vpc.main.id
  description = "Allow SSH"

  ingress {
    description = "SSH TCP"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH UDP"
    from_port = 22
    to_port = 22
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg.ssh.${var.domain}"
  }
}

resource "aws_security_group" "web" {
  name = "sg.web.${var.domain}"
  vpc_id = aws_vpc.main.id
  description = "Allow HTTP and HTTPS"

  ingress {
    description = "HTTP TCP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP UDP"
    from_port = 80
    to_port = 80
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS TCP"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS UDP"
    from_port = 443
    to_port = 443
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg.web.${var.domain}"
  }
}

resource "aws_security_group" "egress" {
  name = "sg.egress.${var.domain}"
  vpc_id = aws_vpc.main.id
  description = "Allow internet access"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg.egress.${var.domain}"
  }
}

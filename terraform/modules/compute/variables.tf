variable "private_key_path" { 
  type = string
  default = "~/.ssh/id_rsa"
}

variable "ssh_user" {
  type = string
  default = "admin"
}

variable "domain" {
  type = string
}

variable "subnet_prod_a" {
  type = any
}

variable "sg_ssh" {
  type = any
}

variable "sg_web" {
  type = any
}

variable "sg_egress" {
  type = any
}

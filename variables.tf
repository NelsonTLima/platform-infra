variable "aws_secret_key" {
  type      = string
  sensitive = true
}

variable "aws_access_key" {
  type      = string
  sensitive = true
}

variable "private_key_path" {
  type    = string
  default = "~/.ssh/id_rsa"
}

variable "ssh_user" {
  type    = string
  default = "admin"
}

variable "cloudflare_api_token" {
  type      = string
  sensitive = true
}

variable "domain" {
  type    = string
}

variable "zone_id" {
  type      = string
  sensitive = true
}

variable "playbook_path" {
  type    = string
  default = ""
}

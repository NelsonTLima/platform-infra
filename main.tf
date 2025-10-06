terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "networking" {
  source      = "./terraform-modules/networking"
  domain      = var.domain
}

module "compute" {
  source           = "./terraform-modules/compute"
  depends_on       = [module.networking]
  
  domain           = var.domain
  ssh_user         = var.ssh_user
  private_key_path = var.private_key_path
  
  subnet_prod_a    = module.networking.subnet_prod_a

  sg_ssh           = module.networking.sg_ssh
  sg_web           = module.networking.sg_web
  sg_egress        = module.networking.sg_egress
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

module "dns" {
  source        = "./terraform-modules/dns"
  projects_file = "${path.root}/provision.yaml"
  zone_id       = var.zone_id
  domain        = var.domain
  ec2_ipv4      = module.compute.ipv4
}

resource "local_file" "ansible_inventory" {
  content  = module.compute.ansible_inventory
  filename = "${path.module}/inventory.yaml"
  file_permission = "0600"
}

resource "null_resource" "ansible_provision" {
  depends_on = [local_file.ansible_inventory]
  count = var.playbook_path == "" ? 0 : 1

  provisioner "local-exec" {
    command = <<-EOC
      sleep 10 &&
      ANSIBLE_HOST_KEY_CHECKING=False \
      setsid ansible-playbook -i ${local_file.ansible_inventory.filename} \
      ${var.playbook_path} \
      < /dev/tty > /dev/tty 2>&1 &
    EOC
  }
}

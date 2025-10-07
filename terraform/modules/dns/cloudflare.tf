terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

locals {
  domains_file = yamldecode(file(var.app_domains))
}


locals {
  domains = flatten([
    for i in local.domains_file["projects"] : [
      for domain in i.domains : {
        name  = domain.name
        type  = domain.type
        dest  = domain.dest
        proxied = domain.proxied
      }
    ]
  ])
}

resource "cloudflare_dns_record" "www"{
  for_each = {
    for domain in local.domains : "${domain.name}" => domain
  }

  zone_id = var.zone_id
  content = each.value.dest != "" ? each.value.dest : var.ec2_ipv4
  name    = each.value.name
  proxied = each.value.proxied
  type    = each.value.type
  ttl     = 1
}

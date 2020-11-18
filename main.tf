terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "2.13.2"
    }
  }
}

variable "cloudflare_api_token" {}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

locals {
  cf01_eu_zone_id = "4e889696e079215601fe7a522126b87e"
}

resource "cloudflare_zone_settings_override" "cf01_eu" {
  zone_id = local.cf01_eu_zone_id
  settings {
    automatic_https_rewrites = "on"
    ssl                      = "full"
  }
}

resource "cloudflare_record" "cf01_eu" {
  zone_id = local.cf01_eu_zone_id
  name    = "@"
  value   = "139.59.205.101"
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "www_cf01_eu" {
  zone_id = local.cf01_eu_zone_id
  name    = "www"
  value   = cloudflare_record.cf01_eu.hostname
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

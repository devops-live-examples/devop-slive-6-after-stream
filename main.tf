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

resource "cloudflare_zone" "cf01_eu" {
  zone = "cf01.eu"
}

output "cf01_eu_name_servers" {
  value = cloudflare_zone.cf01_eu.name_servers
}

resource "cloudflare_zone_settings_override" "cf01_eu" {
  zone_id = cloudflare_zone.cf01_eu.id
  settings {
    automatic_https_rewrites = "off"
    ssl                      = "full"
  }
}

resource "cloudflare_record" "cf01_eu" {
  zone_id = cloudflare_zone.cf01_eu.id
  name    = "@"
  value   = "91.121.89.212"
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "www_cf01_eu" {
  zone_id = cloudflare_zone.cf01_eu.id
  name    = "www"
  value   = cloudflare_record.cf01_eu.hostname
  type    = "CNAME"
  ttl     = 1
  proxied = true
}


resource "cloudflare_record" "foo_cf01_eu" {
  zone_id = cloudflare_zone.cf01_eu.id
  name    = "foo"
  value   = cloudflare_record.cf01_eu.hostname
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_page_rule" "foobar" {
  zone_id  = cloudflare_zone.cf01_eu.id
  target   = "foo.cf01.eu/*"
  priority = 1

  actions {
    forwarding_url {
      url         = "https://cf01.eu"
      status_code = 301
    }
  }
}

resource "cloudflare_zone" "cf03_eu" {
  zone = "cf03.eu"
}

output "cf03_eu_name_servers" {
  value = cloudflare_zone.cf03_eu.name_servers
}

resource "cloudflare_zone_settings_override" "cf03_eu" {
  zone_id = cloudflare_zone.cf03_eu.id
  settings {
    automatic_https_rewrites = "on"
    ssl                      = "full"
  }
}

resource "cloudflare_record" "cf03_eu" {
  zone_id = cloudflare_zone.cf03_eu.id
  name    = "@"
  value   = "91.121.89.212"
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "www_cf04_eu" {
  zone_id = cloudflare_zone.cf03_eu.id
  name    = "www"
  value   = cloudflare_record.cf03_eu.hostname
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

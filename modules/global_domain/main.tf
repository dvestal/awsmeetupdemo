provider "aws" {
  region  = "us-east-1"
  version = "~> 2.1"
}

data "aws_route53_zone" "selected" {
  name = "vestal.pw."
}

resource "aws_route53_record" "www" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "www.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "30"

  records = [
    "${var.aws}",
    "${var.azure}",
    "${var.gcp}",
    "${var.linode}",
    "${var.digitalocean}",
  ]
}

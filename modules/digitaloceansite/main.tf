provider "digitalocean" {}

resource "digitalocean_ssh_key" "default" {
  name       = "AWS Meetup Terraform Example"
  public_key = "${var.ssh_key}"
}

resource "digitalocean_droplet" "web" {
  image    = "ubuntu-18-04-x64"
  name     = "web-1"
  region   = "nyc1"
  size     = "s-1vcpu-1gb"
  ssh_keys = ["${digitalocean_ssh_key.default.fingerprint}"]
}

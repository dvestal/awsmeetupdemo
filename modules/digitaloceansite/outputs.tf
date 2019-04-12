output "digitalocean-machine" {
  value = "${digitalocean_droplet.web.ipv4_address}"
}

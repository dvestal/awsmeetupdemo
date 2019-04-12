output "linode-machine" {
  value = "${linode_instance.web.ip_address}"
}

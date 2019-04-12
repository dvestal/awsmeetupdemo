output "azure-machine" {
  value = "${data.azurerm_public_ip.test.ip_address}"
}

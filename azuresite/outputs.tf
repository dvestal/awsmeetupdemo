output "azure-machine" {
  value = "${azurerm_public_ip.test.ip_address}"
}

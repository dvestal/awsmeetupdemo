output "aws" {
  value = "${module.awssite.aws-machine}"
}

output "azure" {
  value = "${module.azuresite.azure-machine}"
}

output "google" {
  value = "${module.googlesite.gcp-machine}"
}

output "linode" {
  value = "${module.linodesite.linode-machine}"
}

output "digitalocean" {
  value = "${module.digitaloceansite.digitalocean-machine}"
}

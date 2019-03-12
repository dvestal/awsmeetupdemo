data "template_file" "inventory" {
  template = "${file("${path.module}/ansible_hosts.tpl")}"

  vars = {
    aws_address    = "${module.awssite.aws-machine}"
    azure_address  = "${module.azuresite.azure-machine}"
    gcp_address    = "${module.googlesite.gcp-machine}"
    linode_address = "${module.linodesite.linode-machine}"
    do_address     = "${module.digitaloceansite.digitalocean-machine}"
  }
}

resource "local_file" "inventory" {
  content  = "${data.template_file.inventory.rendered}"
  filename = "${path.module}/inventory.txt"
}

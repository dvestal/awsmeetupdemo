# SGF AWS Meetup

###############################################################################
# Setup/Config
###############################################################################

terraform {
  backend "s3" {
    bucket         = "awsmeetup-tfstate"
    key            = "meetupdemo"
    region         = "us-east-1"
    dynamodb_table = "awsmeetup-tfstate"
    encrypt        = true
  }
}

###############################################################################
# Resources
###############################################################################

data "local_file" "ssh" {
  filename = "${pathexpand("~/.ssh/gmail_rsa.pub")}"
}

module "awssite" {
  source  = "./modules/awssite"
  ssh_key = "${chomp(data.local_file.ssh.content)}"
}

module "azuresite" {
  source  = "./modules/azuresite"
  ssh_key = "${chomp(data.local_file.ssh.content)}"
}

module "googlesite" {
  source  = "./modules/googlesite"
  ssh_key = "${chomp(data.local_file.ssh.content)}"
}

module "linodesite" {
  source  = "./modules/linodesite"
  ssh_key = "${chomp(data.local_file.ssh.content)}"
}

module "digitaloceansite" {
  source  = "./modules/digitaloceansite"
  ssh_key = "${chomp(data.local_file.ssh.content)}"
}

module "router" {
  source = "./modules/global_domain"

  aws          = "${module.awssite.aws-machine}"
  azure        = "${module.azuresite.azure-machine}"
  gcp          = "${module.googlesite.gcp-machine}"
  linode       = "${module.linodesite.linode-machine}"
  digitalocean = "${module.digitaloceansite.digitalocean-machine}"
}

###############################################################################
# Outputs
###############################################################################

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

output "website" {
  value = "http://www.vestal.pw"
}

# SGF AWS Meetup

module "awssite" {
  source = "./awssite"
}

module "azuresite" {
  source = "./azuresite"
}

module "googlesite" {
  source = "./googlesite"
}

module "linodesite" {
  source = "./linodesite"
}

module "digitaloceansite" {
  source = "./digitaloceansite"
}

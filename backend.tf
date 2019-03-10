terraform {
  backend "s3" {
    bucket         = "awsmeetup-tfstate"
    key            = "meetupdemo"
    region         = "us-east-1"
    dynamodb_table = "awsmeetup-tfstate"
    encrypt        = true
  }
}

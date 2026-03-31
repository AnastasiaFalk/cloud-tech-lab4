terraform {
  required_version = ">= 1.10.0"

  backend "s3" {
    bucket       = "tf-state-falkovska-anastasiia-20-v2"
    key          = "terraform.tfstate"
    region       = "eu-central-1"
    use_lockfile = true
  }
}
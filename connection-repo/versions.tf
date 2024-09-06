terraform {
  required_providers {
    hcp = {
      source = "hashicorp/hcp"
      version = "0.95.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.66.0"
    }
  }
}

provider "hcp" {
  # Configuration options
}

provider "aws" {
  # Configuration options
}
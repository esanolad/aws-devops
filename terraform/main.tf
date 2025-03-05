terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ca-central-1"
  
}

variable "sol_tf_prefix" {
  default = "sol_tf"
}

variable "sol_tf_users" {
  default = ["dew", "msa", "sola", "maja", "kama"]
}
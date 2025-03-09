
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "ent-terraform-backend"
    key            = "appname/project/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-backend-lock"
  }
}

provider "aws" {
  region = "us-east-1"

}

resource "aws_iam_user" "name" {
  name = "${terraform.workspace}-my_iam_user"
}
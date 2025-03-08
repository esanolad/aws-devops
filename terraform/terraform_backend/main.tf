terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
#   backend "s3" {
#     bucket         = "ent-terraform-backend"
#     key            = "path/to/your/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "your-dynamodb-table"
#   }
}



provider "aws" {
  region = "us-east-1"

}
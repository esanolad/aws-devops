variable "app-name" {
  description = "The name of the application"
  type        = string
  default = "infra"
  
}

variable "env-name" {
  description = "The name of the environment"
  type        = string
  default = "dev"
  
}

variable "project-name" {
  description = "The name of the project"
  type        = string
  default = "terraform"
  
}

variable "bucket" {
  description = "value of the bucket"
  type        = string
  default = "ent-terraform-backend"
}

variable "region" {
  description = "value of the region"
  type        = string
  default = "us-east-1"
  
}

variable "dynamodb_table" {
  description = "value of the dynamodb_table"
  type        = string
  default = "terraform-backend-lock"
  
}
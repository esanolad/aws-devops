# Create a VPC
resource "aws_vpc" "tf_aws_vpc" {
  cidr_block = "10.10.0.0/16"

  tags = {
    Name = "${var.sol_tf_prefix}_vpc"
  }
}

resource "aws_s3_bucket" "tf_aws_s3_bucket" {
  bucket = "sol-tf-test-bucket"
  # versioning {
  #   enabled = true
  # }
  tags = {
    Name = "${var.sol_tf_prefix}_bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "tf_versioning_example" {
  bucket = aws_s3_bucket.tf_aws_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_iam_user" "my_aws_iam_user" {
  count = length(var.sol_tf_users)
  name = "${var.sol_tf_prefix}_iam_user_${var.sol_tf_users[count.index]}"
  # name = "${var.sol_tf_prefix}_iam_user_${count.index}"
}


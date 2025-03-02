output "aws_s3_bucket_id" {
  value=aws_s3_bucket.tf_aws_s3_bucket.bucket_domain_name
}

output "aws_iam_user_id" {
  value=aws_iam_user.my_aws_iam_user.unique_id
}

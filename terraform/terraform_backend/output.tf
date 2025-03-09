output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.name.id
}

output "instance_ip" {
  description = "The public IP address of the instance"
  value       = aws_instance.web.public_ip
  
}
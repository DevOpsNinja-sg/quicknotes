output "ec2_instance_ips" {
  description = "Public IPs of EC2 instances"
  value       = [for instance in aws_instance.ec2_instance : instance.public_ip]
}

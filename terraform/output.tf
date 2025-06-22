output "ec2_instance_ips" {
  value       = module.prod-infra.ec2_instance_ips
  description = "Public IPs of the EC2 instances from module"
}

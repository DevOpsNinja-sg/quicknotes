variable "environment" {
  description = "The environment for which the resources are being created (e.g., dev, staging, prod)."
  type        = string
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to create."
  type        = string
  default     = "t2.micro"
}

variable "instance_count" {
  description = "The number of EC2 instances to create."
  type        = number
  default     = 1
}
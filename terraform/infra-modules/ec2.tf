resource "aws_key_pair" "key_pair" {
    key_name = "${var.environment}-key"
    public_key = file("./key/${var.environment}-key.pub")

    tags = {
        Name = "${var.environment}-key"
        Environment = var.environment
    }
}

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "security_group" {
    name        = "${var.environment}-security-group"
    description = "Security group for ${var.environment} environment"
    vpc_id      = aws_default_vpc.default.id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow SSH access from anywhere"
    }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow HTTP access from anywhere"
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound traffic"
    }

    tags = {
        Name        = "${var.environment}-security-group"
        Environment = var.environment
    }
}

resource "aws_instance" "ec2_instance" {
    ami           = var.ami_id
    count         = var.instance_count
    instance_type = var.instance_type
    key_name      = aws_key_pair.key_pair.key_name
    security_groups = [aws_security_group.security_group.name]
    depends_on = [aws_key_pair.key_pair, aws_security_group.security_group]
    root_block_device {
        volume_size = var.environment == "prod" ? 16:8
        volume_type = "gp3"
        delete_on_termination = true
    }
    tags = {
        Name        = "${var.environment}-ec2-instance"
        Environment = var.environment
    }
}
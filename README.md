# 📝 QuickNotes Deployment Automation

This project automates the provisioning, configuration, and deployment of the [QuickNotes] web application on an AWS EC2 instance using **Terraform**, **Ansible**, and **Docker**.

<img width="958" alt="Screenshot 2025-06-23 005906" src="https://github.com/user-attachments/assets/f63e7115-d4db-458c-92c0-07ec269b2a0e" />

---

## 📦 Project Structure

```
quicknotes/
├── ansible/                      # Ansible playbook and inventory for configuration
│   ├── inventory.ini
│   ├── playbook.yml
│   └── roles/
│       └── docker/
│           └── tasks/
│               └── main.yml
├── app/                          # Flask application source code
│   ├── static/
│   ├── templates/
│   └── ...
├── terraform/                    # Terraform scripts to provision AWS infrastructure
│   ├── main.tf
│   ├── provider.tf
│   ├── output.tf
│   ├── terraform.tf
│   └── key/
│       ├── prod-key              # Private key used for SSH
│       └── prod-key.pub          # Public key
├── aws/                          # AWS CLI installer or dependencies
├── generate_inventory.py         # Script to auto-generate Ansible inventory
├── provision_and_deploy.sh       # End-to-end provisioning and deployment script
├── docker-compose.yml            # Docker Compose config for the app
├── Dockerfile                    # Dockerfile for the Flask app
├── requirements.txt              # Python requirements
└── README.md                     
```


## 🚀 Features

- **Infrastructure as Code** using Terraform
- **Configuration Management** using Ansible
- **Containerization** with Docker and Docker Compose
- **Flask Application** with persistent volume for note storage
- **Remote Backend** Terraform state is stored in an S3 bucket with DynamoDB lock to enable collaboration and safe state management.
---

## 🔧 Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) with configured credentials
- [Python 3](https://www.python.org/)
- An AWS account with permissions to create EC2, VPC, and related resources

---

## ⚙️ Setup Instructions

### 1. Configure AWS Credentials

Ensure your AWS credentials are configured, e.g.:

aws configure
Or export them as environment variables:

export AWS_ACCESS_KEY_ID=your-access-key
export AWS_SECRET_ACCESS_KEY=your-secret-key

## 2. How it Works🔧

1. **Terraform** provisions:
   - EC2 instance
   - Security group with port 80 open
   - Key pair and outputs IP to a file

2. **Python script** (`generate_inventory.py`):
   - Parses Terraform output
   - Auto-generates `inventory.ini` for Ansible

3. **Ansible** playbook:
   - Installs Docker and Docker Compose
   - Clones QuickNotes GitHub repo
   - Runs the application via Docker Compose

### 3. Provision Infrastructure + Deploy App

sh provision_and_deploy.sh
This script will:

Run terraform apply to create AWS resources

Extract EC2 IP and generate an Ansible inventory file

Run Ansible playbook to install Docker, clone the app, and start it

### 🌐 Access the Application
Once deployment is complete, open the EC2 instance’s public IP in your browser.

Example:
http://<EC2_PUBLIC_IP>

Port 80 is exposed and mapped to the app's internal 5000 port via Docker Compose.

### 🛠 Troubleshooting

SSH Permission Denied

Make sure the private key file has correct permissions:
chmod 400 terraform/key/key_name

Docker Not Installed
Check that the Ansible role is correctly included in playbook.yml and paths are correct.

Run Ansible in verbose mode:

ansible-playbook -i ansible/inventory.ini ansible/playbook.yml -vvv

### 📌 Notes

The SSH key is auto-generated and stored in terraform/key/

The instance is Ubuntu-based (user: ubuntu)

Docker Compose is downloaded from GitHub releases

The playbook uses become: true to gain root privileges


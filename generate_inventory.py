import json

# Load Terraform output JSON
with open('terraform/output.json') as f:
    data = json.load(f)

# Get list of IPs
ips = data["ec2_instance_ips"]["value"]

# Write to Ansible inventory file
with open('ansible/inventory.ini', 'w') as f:
    f.write("[quicknotes]\n")
    for ip in ips:
        f.write(f"{ip} ansible_user=ubuntu ansible_ssh_private_key_file=terraform/key/prod-key\n")

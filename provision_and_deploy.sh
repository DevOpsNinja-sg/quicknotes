#!/bin/bash

echo "🔧 Running Terraform..."
cd terraform
terraform init
# Initialize and apply Terraform
terraform apply -auto-approve
if [ $? -ne 0 ]; then
  echo "❌ Terraform apply failed. Exiting."
  exit 1
fi

terraform output -json > output.json
echo "✅ Terraform completed successfully."

cd ..

# Generate dynamic Ansible inventory
echo "🛠️ Generating Ansible inventory..."
python3 generate_inventory.py
if [ $? -ne 0 ]; then
  echo "❌ Failed to generate Ansible inventory. Exiting."
  exit 1
fi

# Run Ansible playbook
echo "🚀 Running Ansible playbook..."
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml \
--ssh-extra-args="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
if [ $? -ne 0 ]; then
  echo "❌ Ansible playbook failed. Exiting."
  exit 1
fi

echo "✅ Deployment completed successfully!"

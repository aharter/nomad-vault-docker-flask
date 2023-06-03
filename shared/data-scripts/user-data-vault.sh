#!/bin/bash

set -e

exec > >(sudo tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Install jq
sudo apt-get install jq

# Install consul-template
curl -L https://releases.hashicorp.com/consul-template/0.32.0/consul-template_0.32.0_linux_amd64.zip > consul-template.zip
sudo unzip consul-template.zip -d /usr/local/bin
sudo chmod 0755 /usr/local/bin/consul-template
sudo chown root:root /usr/local/bin/consul-template

# Install Vault
VAULT_VERSION="1.13.2"
VAULT_DOWNLOAD="https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip"
curl -L ${VAULT_DOWNLOAD} > vault.zip
sudo unzip vault.zip -d /usr/local/bin
sudo chmod 0755 /usr/local/bin/vault
sudo chown root:root /usr/local/bin/vault

# Configure Vault as CA
# sudo mkdir -p /etc/vault
# sudo touch /etc/vault/config.hcl

# cat <<EOF | sudo tee /etc/vault/config.hcl
# listener "tcp" {
#   address       = "0.0.0.0:8200"
#   tls_cert_file = "/etc/vault/tls.crt"
#   tls_key_file  = "/etc/vault/tls.key"
# }

# storage "file" {
#   path = "/etc/vault/data"
# }

# api_addr = "http://127.0.0.1:8200"
# cluster_addr = "https://127.0.0.1:8201"
# ui = true

# seal "awskms" {
#   region = "your_aws_region"
#   kms_key_id = "your_kms_key_id"
# }

# # Add any additional configuration parameters as needed
EOF

# Start Vault service
sudo systemctl enable vault
sudo systemctl start vault

# Initialize Vault and retrieve the initial root token
# VAULT_ADDR=http://127.0.0.1:8200
# export VAULT_ADDR
# sudo vault operator init -key-shares=1 -key-threshold=1 > /tmp/vault_init_output
# export VAULT_TOKEN=$(grep "Initial Root Token:" /tmp/vault_init_output | awk '{print $NF}')

# # Store the root token securely (you can modify this as per your requirements)
# echo "VAULT_ROOT_TOKEN=${VAULT_TOKEN}" | sudo tee /etc/vault/root_token

# Clean up temporary files
rm /tmp/vault_init_output

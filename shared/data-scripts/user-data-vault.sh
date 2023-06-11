#!/bin/bash

set -e

exec > >(sudo tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

CONFIGDIR="/ops/shared/config"
VAULTCONFIGDIR="/etc/vault"

# Prepare instance
sudo apt update
sudo apt install unzip

# Install jq
echo "Starting jq install"
sudo snap install jq

# # Install Vault from Binary
# echo "Starting Vault Install"
# wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
# echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
# sudo apt update && sudo apt install vault
# echo "Concluded Vault Installation"

# Configure Vault
sudo mkdir $VAULTCONFIGDIR
sudo chmod 0755 $VAULTCONFIGDIR
sudo cp $CONFIGDIR/vault.hcl $VAULTCONFIGDIR/vault.hcl
sudo cp $CONFIGDIR/vault.service /usr/lib/systemd/system/vault.service
export VAULT_ADDR="http://127.0.0.1:8200"
# sudo systemctl enable vault
# sudo systemctl restart vault
echo "Concluded Vault Preparation"

# # Initialize Vault and retrieve the initial root token
# sudo vault operator init -key-shares=1 -key-threshold=1 > /tmp/vault_init_output
# export VAULT_TOKEN=$(grep "Initial Root Token:" /tmp/vault_init_output | awk '{print $NF}')

# # Store the root token securely (you can modify this as per your requirements)
# echo "VAULT_ROOT_TOKEN=${VAULT_TOKEN}" | sudo tee /etc/vault/root_token

# # Clean up temporary files
# rm /tmp/vault_init_output
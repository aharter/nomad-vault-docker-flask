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

# Install consul-template
echo "Starting Consul-Template Installation"
curl -L https://releases.hashicorp.com/consul-template/0.32.0/consul-template_0.32.0_linux_amd64.zip > consul-template.zip
sudo unzip consul-template.zip -d /usr/local/bin
sudo chmod 0755 /usr/local/bin/consul-template
sudo chown root:root /usr/local/bin/consul-template
echo "Concluded Consul-Template Installation"

# Install Vault from Binary
echo "Starting Vault Install"
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vault
# sudo cp $CONFIGDIR/vault.hcl $VAULTCONFIGDIR/vault.hcl
# sudo cp $CONFIGDIR/vault.service /etc/systemd/system/nomad.service
# sudo systemctl restart vault
# export VAULT_ADDR="http://127.0.0.1:8200"
# echo "Concluded Vault Install"

# # Move Vault config files 
# echo "Moving Vault Config files"
# sudo mkdir /etc/vault
# sudo chmod 0755 /etc/vault
# sudo chown root:root /etc/vault
# sudo chown root:root /etc/vault/config.hcl
# sudo chmod 640 /etc/vault/config.hcl
# sudo cp $CONFIGDIR/vault.hcl $VAULTCONFIGDIR/vault.hcl
# sudo cp $CONFIGDIR/vault.service /etc/systemd/system/nomad.service
# echo "Moved Vault Config Files"

# # Install Vault
# echo "Starting Vault Installation"
# curl -L https://releases.hashicorp.com/vault/1.13.2/vault_1.13.2_linux_amd64.zip > vault.zip
# sudo unzip vault.zip -d /usr/local/bin
# sudo chmod 0755 /usr/local/bin/vault
# sudo chown root:root /usr/local/bin/vault

# sudo mkdir /etc/vault/data
# sudo chown root:root /etc/vault/data
# sudo chmod 750 /etc/vault/data
# export VAULT_ADDR="http://127.0.0.1:8200"
# echo "Concluded Vault Configuration"

# # Start Vault Server
# echo "Starting Vault Server"
# sudo systemctl enable vault
# sudo systemctl start vault

# # Initialize Vault and retrieve the initial root token
# sudo vault operator init -key-shares=1 -key-threshold=1 > /tmp/vault_init_output
# export VAULT_TOKEN=$(grep "Initial Root Token:" /tmp/vault_init_output | awk '{print $NF}')
# echo "Concluded Vault Initialization"

# # Store the root token securely (you can modify this as per your requirements)
# echo "VAULT_ROOT_TOKEN=${VAULT_TOKEN}" | sudo tee /etc/vault/root_token

# # Clean up temporary files
# rm /tmp/vault_init_output
# echo "Concluded Vault Configuration"

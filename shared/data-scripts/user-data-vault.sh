#!/bin/bash

set -e

exec > >(sudo tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

CONFIGDIR="/ops/shared/config"
VAULTCONFIGDIR="/etc/vault.d"
IP_ADDRESS=$(curl http://instance-data/latest/meta-data/local-ipv4)
IP_ADDRESS_PUBLIC=$(curl http://instance-data/latest/meta-data/public-ipv4)

# Prepare instance
sudo apt update
sudo apt install unzip


# Install jq
echo "Starting jq install"
sudo snap install jq


# Install Vault
echo "Starting Vault Install"
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vault

sed -i "s|IP_ADDRESS|$IP_ADDRESS|g" $CONFIGDIR/vault.hcl
sed -i "s|IP_ADDRESS_PUBLIC|$IP_ADDRESS_PUBLIC|g" $CONFIGDIR/vault.hcl
# sudo mkdir $VAULTCONFIGDIR
# sudo chmod 0755 $VAULTCONFIGDIR
sudo cp $CONFIGDIR/vault.hcl $VAULTCONFIGDIR/vault.hcl
sudo mkdir -p /usr/lib/systemd/system
sudo cp $CONFIGDIR/vault.service /usr/lib/systemd/system/vault.service

sudo systemctl enable vault
sudo systemctl restart vault

echo "Vault started"

# Initialize Vault and retrieve the initial root token
sudo vault operator init -key-shares=1 -key-threshold=1 > /tmp/vault_init_output
export VAULT_TOKEN=$(grep "Initial Root Token:" /tmp/vault_init_output | awk '{print $NF}')

# Store the root token securely (you can modify this as per your requirements)
echo "VAULT_ROOT_TOKEN=${VAULT_TOKEN}" | sudo tee /etc/vault/root_token

# # Clean up temporary files
rm /tmp/vault_init_output

echo "Vault setup concluded"
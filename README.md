Setup
- Vault: Check automated generation of certificates
- Enable TLS in Nomad Servers & Clients
    - https://developer.hashicorp.com/nomad/tutorials/integrate-vault/vault-pki-nomad


2do: 
- Main: Save private key to AWS
- Vault: Check certificate handling after new apply
- Git Hub: Clean up GitHub 
- Vault: Enable Gossip Encryption for Nomad
    - https://developer.hashicorp.com/nomad/tutorials/transport-security/security-gossip-encryption
- Nomad: Deploy Nomad job with example app
- Nomad: Deploy Nomad job with React app
- Make download URLs dynamic again
- DONE: Obtain nomad secret ID (nomad acl bootstrap)
- DONE: Create AMI of all instance types
- DONE: Provide final configuration for Vault in config
- DONE: Make Vault address dynamic
- DONE: Add populated configuration files for consul-template
- DONE: Add consult-template.service to all instances
- DONE: Configure user-data-vault.sh => fail ab config.hcl für Vault 
- DONE: Investigate missing installation of consul-template on all instances
- DONE: Add echoes to .sh scripts
- DONE: Vault: sudo snap install jq
- DONE: Figure out key handling (either access to private key or use existing)
- DONE: Set instance name for vault as tag "Name" = "${var.name}-server-${count.index}


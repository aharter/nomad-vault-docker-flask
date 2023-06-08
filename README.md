Setup
- Extract private key from state
- Check certificates in Vault
- Enable TLS in Nomad Servers & Clients
- Obtain nomad secret ID (nomad acl bootstrap)


2do: 
- Enable Gossip Encryption for Nomad
- Make download URLs dynamic again
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


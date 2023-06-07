2do: 
- Provide final configuration for Vault in config
- Add populated configuration files for consul-template
- Add consult-template.service to all instances
- DONE: Configure user-data-vault.sh => fail ab config.hcl für Vault 
- DONE: Investigate missing installation of consul-template on all instances
- Make download URLs dynamic again
- DONE: Add echoes to .sh scripts
- DONE: Vault: sudo snap install jq
- DONE: Figure out key handling (either access to private key or use existing)
- DONE: Set instance name for vault as tag "Name" = "${var.name}-server-${count.index}


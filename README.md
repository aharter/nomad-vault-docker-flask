This is for setting up and running a secure (mTLS) Nomad Cluster with Vault as CA using self-signed certificates. While all of the clusters internal communication is secured, it is accessible externally over https only. Waypoint is used for deploying a sample Docker-Flask Web Application. 

Please note: This is not a production setup. 

Notes:

2do:
- TF: Save private key to AWS/ Vault Secrets
- Git Hub: Clean up GitHub 
- Vault: Enable Gossip Encryption for Nomad
    - https://developer.hashicorp.com/nomad/tutorials/transport-security/security-gossip-encryption
- TF: Make all download URLs dynamic



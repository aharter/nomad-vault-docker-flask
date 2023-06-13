Terraform for setting up and running a secure (mTLS) Nomad Cluster with Vault as CA using self-signed certificates. While the cluster's internal communication is secured the cluster is externally availble over http only to save Certificate hassle. Waypoint is used for deploying a sample Docker-Flask Web Application. You can access the Nomad- and Vault UI on their public IPs, see output.tf for details. 

Please note: This is not a production setup. 

Notes:


2do:
- TF: Save private key to AWS/ Vault Secrets
- Vault: Enable Gossip Encryption for Nomad
    - https://developer.hashicorp.com/nomad/tutorials/transport-security/security-gossip-encryption
- TF: Make all download URLs dynamic

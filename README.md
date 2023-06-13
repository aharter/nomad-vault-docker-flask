Terraform for setting up and running a secure (mTLS) Nomad Cluster with Vault as CA using self-signed certificates and Consul-Template. While the cluster is secured 

s internal communication is secured it is externally availble over http only to save Certificate hassle. Waypoint is used for deploying a sample Docker-Flask Web Application. You can access the Nomad- and Vault UI on their public IPs, see output.tf for details. 

Please note: This is not a production setup. 
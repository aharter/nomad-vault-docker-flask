SETUP INSTRUCTIONS

Nomad: Deploy jobs from CLI
    - export NOMAD_ADDR=http://localhost:4646
    - ssh -i tf-key.pem -L 4646:localhost:4646 ubuntu@IP_ADDRESS
    - nomad status -address=http://localhost:4646
    - nomad job run pytechco-redis.nomad.hcl
    - nomad job run pytechco-web.nomad.hcl
    - nomad node status -verbose \
    $(nomad job allocs pytechco-web | grep -i running | awk '{print $2}') | \
    grep -i public-ipv4 | awk -F "=" '{print $2}' | xargs | \
    awk '{print "http://"$1":5000"}'
    - nomad job run pytechco-setup.nomad.hcl
    - nomad job dispatch -meta budget="200" pytechco-setup
    - nomad job run pytechco-employee.nomad.hcl


Vault: Secure cluster 
- Update vault.hcl with IP(s)
- Connect with browser to IP_ADDRESS:8200 for initial root token & key
- Enable TLS in Nomad Servers & Clients
    - https://developer.hashicorp.com/nomad/tutorials/integrate-vault/vault-pki-nomad


2do: 
- Vault: Check why host IP doesn't get generated dynamically
- TF: Save private key to AWS
- Git Hub: Clean up GitHub 
- Vault: Enable Gossip Encryption for Nomad
    - https://developer.hashicorp.com/nomad/tutorials/transport-security/security-gossip-encryption
- TF: Make download URLs dynamic again



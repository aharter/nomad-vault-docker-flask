HOW TO: Deploy Nomad jobs from your local CLI
export NOMAD_ADDR=http://localhost:4646
ssh -i tf-key.pem -L 4646:localhost:4646 ubuntu@IP_ADDRESS
nomad status -address=http://localhost:4646
nomad job run pytechco-redis.nomad.hcl
nomad job run pytechco-web.nomad.hcl
nomad node status -verbose \
    $(nomad job allocs pytechco-web | grep -i running | awk '{print $2}') | \
    grep -i public-ipv4 | awk -F "=" '{print $2}' | xargs | \
    awk '{print "http://"$1":5000"}'
nomad job run pytechco-setup.nomad.hcl
nomad job dispatch -meta budget="200" pytechco-setup
nomad job run pytechco-employee.nomad.hcl

HOW TO: Secure Nomad Cluster with Vault as CA
(export VAULT_SKIP_VERIFY=true)
export VAULT_ADDR="http://VAULT_IP:8200"
vault operator init -key-shares=1 -key-threshold=1
vault operator unseal
vault login
vault secrets enable pki
vault secrets tune -max-lease-ttl=87600h pki
vault write -field=certificate pki/root/generate/internal \
    common_name="global.nomad" ttl=87600h > CA_cert.crt
vault secrets enable -path=pki_int pki
vault secrets tune -max-lease-ttl=43800h pki_int
vault write -format=json pki_int/intermediate/generate/internal \
    common_name="global.nomad Intermediate Authority" \
    ttl="43800h" | jq -r '.data.csr' > pki_intermediate.csr
vault write -format=json pki/root/sign-intermediate \
    csr=@pki_intermediate.csr format=pem_bundle \
    ttl="43800h" | jq -r '.data.certificate' > intermediate.cert.pem
vault write pki_int/intermediate/set-signed certificate=@intermediate.cert.pem
vault write pki_int/roles/nomad-cluster allowed_domains=global.nomad \
    allow_subdomains=true max_ttl=86400s require_cn=false generate_lease=true
sudo nano tls-policy.hcl:

path "pki_int/issue/nomad-cluster" {
  capabilities = ["update"]
  }

vault policy write tls-policy tls-policy.hcl
MAKE NOTE OF TOKEN: vault token create -policy="tls-policy" -period=24h -orphan

On all Nomad nodes
sudo nano /etc/consul-template.d/consul-template.hcl (IP & Token)
sudo systemctl start consul-template.service
sudo nano /etc/nomad.d/nomad.hcl (uncomment TLS & Server: rpc_upgrade_mode = true)
sudo systemctl restart nomad
sudo nano /etc/nomad.d/nomad.hcl (#rpc_upgrade_mode = true)

Sources:
https://developer.hashicorp.com/nomad/tutorials/integrate-vault/vault-pki-nomad
https://developer.hashicorp.com/nomad/tutorials/transport-security/security-gossip-encryption

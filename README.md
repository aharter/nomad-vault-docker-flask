Set up a nomad server with terraform on AWS with its own CA and a React Web App being served via HTTPS.

1: Set up infrastructure (push to remote origina to trigger terraform)
2: Set up the three instances
    Nomad Server: 
        Install & configure nomad
        Install & configure nginx as reverse proxy
        Install & configure node.js & nvm
        Install & configure React.js
    Nomad Client:
        Install & configure nomad
    Vault Server:
        Install & configure vault

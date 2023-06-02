#!/bin/bash

set -e

exec > >(sudo tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1


# Download and install Consul Template
CONSUL_TEMPLATE_VERSION="0.32.0"
CONSUL_TEMPLATE_DOWNLOAD="https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip"
curl -L ${CONSUL_TEMPLATE_DOWNLOAD} > consul-template.zip
sudo unzip consul-template.zip -d /usr/local/bin
sudo chmod 0755 /usr/local/bin/consul-template
sudo chown root:root /usr/local/bin/consul-template

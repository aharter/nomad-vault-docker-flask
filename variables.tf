variable "name" {
  description = "Prefix used to name various infrastructure components. Alphanumeric characters only."
  default     = "nasenblick"
}

variable "region" {
  description = "Region code for AWS"
  default = "us-east-1" 
}

variable "allowlist_ip" {
  description = "IP to allow access for the security groups (set 0.0.0.0/0 for world)"
  default     = "0.0.0.0/0"
}

variable "server_instance_type" {
  description = "The AWS instance type to use for nomad servers."
  default     = "t2.nano"
}

variable "client_instance_type" {
  description = "The AWS instance type to use for nomad clients."
  default     = "t2.nano"
}

variable "vault_instance_type" {
  description = "The AWS instance type to use for vault instances."
  default     = "t2.nano"
}

variable "server_count" {
  description = "The number of servers to provision."
  default     = "1"
}

variable "client_count" {
  description = "The number of clients to provision."
  default     = "1"
}

variable "vault_count" {
  description = "The number of vault instances to provision."
  default     = "1"
}

variable "root_block_device_size" {
  description = "The volume size of the root block device."
  default     = 8
}

variable "nomad_version" {
  description = "The version of the Nomad binary to install."
  default     = "1.5.0"
}

variable "vault_version" {
  description = "The version of the Vault binary to install."
  default     = "1.13.2"
}

variable "private_key_output"{
  description = "SSH privat key for accessing instances"
  default = tls_private_key.private_key.private_key_pem
}

# variable "aws_ssh_public_key" {
#   description = "SSH public key for accessing the instance"
#   type        = string
# }

# variable "private_key" {
#   description = "SSH private key for accessing the instance"
#   type        = string
# }


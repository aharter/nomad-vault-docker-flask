output "nomad_ip" {
  description = "Nomad UI Address"
  value = "http://${aws_instance.server[0].public_ip}:4646/ui"
}

 output "vault_ip" {
   description = "Vault Address"
   value = "https://${aws_instance.vault[0].public_ip}:8200/ui"
 }
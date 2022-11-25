terraform {
  required_providers {
    tls = {
      source = "hashicorp/tls"
      version = "4.0.4"
    }
  }
}

module "misclaves" {
    source = "../modulo"
    forzar_recreacion=false
}

output "miclave_privada" {
    value = module.misclaves.privateKey
    sensitive = true
}
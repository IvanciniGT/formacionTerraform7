output "privateKey" {
    sensitive = true
    value   =   length( tls_private_key.claves ) == 1 ? {
                                                            pem     =   tls_private_key.claves[0].private_key_pem
                                                            openssh =   tls_private_key.claves[0].private_key_openssh
                                                        } : {
                                                            pem     =   local.contenido_fichero_private_pem
                                                            openssh =   local.contenido_fichero_private_openssh
                                                        }
}

output "publicKey" {
    sensitive = true
    value   =   length( tls_private_key.claves ) == 1 ? {
                                                            pem     =   tls_private_key.claves[0].public_key_pem
                                                            openssh =   tls_private_key.claves[0].public_key_openssh
                                                        } : {
                                                            pem     =   local.contenido_fichero_public_pem
                                                            openssh =   local.contenido_fichero_public_openssh
                                                        }
}
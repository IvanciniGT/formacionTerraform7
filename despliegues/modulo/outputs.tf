output "privateKey" {
    value   =   length( tls_private_key.claves ) == 1 ? {
                                                            pem     =   tls_private_key.claves.private_key_pem
                                                            openssh =   tls_private_key.claves.private_key_openssh
                                                        } : {
                                                            pem     =   local.contenido_fichero_private_pem
                                                            openssh =   local.contenido_fichero_private_openssh
                                                        }
}

output "publicKey" {
    value   =   length( tls_private_key.claves ) == 1 ? {
                                                            pem     =   tls_private_key.claves.public_key_pem
                                                            openssh =   tls_private_key.claves.public_key_openssh
                                                        } : {
                                                            pem     =   local.contenido_fichero_public_pem
                                                            openssh =   local.contenido_fichero_public_openssh
                                                        }
}
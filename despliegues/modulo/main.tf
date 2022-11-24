locals {
    // Definir expresiones a las que me puedo referir con un nombre
    directorio_claves_validado          = endswith(var.directorio_claves,"/") ? var.directorio_claves : "${var.directorio_claves}/"
    
    nombre_fichero_private_pem          = "${local.directorio_claves_validado}privateKey.pem"
    nombre_fichero_private_openssh      = "${local.directorio_claves_validado}privateKey.openssh"
    nombre_fichero_public_pem           = "${local.directorio_claves_validado}publicKey.pem"
    nombre_fichero_public_openssh       = "${local.directorio_claves_validado}publicKey.openssh"
    
    existe_el_fichero_private_pem       = fileexists( local.nombre_fichero_private_pem        )
    existe_el_fichero_private_openssh   = fileexists( local.nombre_fichero_private_openssh    )
    existe_el_fichero_public_pem        = fileexists( local.nombre_fichero_public_pem         )
    existe_el_fichero_public_openssh    = fileexists( local.nombre_fichero_public_openssh     )

    existen_los_ficheros_claves         = ( local.existe_el_fichero_private_pem     &&
                                            local.existe_el_fichero_private_openssh &&
                                            local.existe_el_fichero_public_pem      &&
                                            local.existe_el_fichero_public_openssh    )
    
    contenido_fichero_private_pem       = local.existe_el_fichero_private_pem       ? file( local.nombre_fichero_private_pem      ) : null
    contenido_fichero_private_openssh   = local.existe_el_fichero_private_openssh   ? file( local.nombre_fichero_private_openssh  ) : null
    contenido_fichero_public_pem        = local.existe_el_fichero_public_pem        ? file( local.nombre_fichero_public_pem       ) : null
    contenido_fichero_public_openssh    = local.existe_el_fichero_public_openssh    ? file( local.nombre_fichero_public_openssh   ) : null
}

resource "tls_private_key" "claves" {
    count       =   local.existen_los_ficheros_claves && ! var.forzar_recreacion ? 0 : 1
    
    algorithm   =   var.algoritmo.nombre
    ecdsa_curve =   var.algoritmo.nombre == "ECDSA" ? var.algoritmo.configuracion   : null
    rsa_bits    =   var.algoritmo.nombre == "RSA"   ? var.algoritmo.configuracion   : null
    
    provisioner "local-exec" {
        command =   <<EOT
                            mkdir -p ${local.directorio_claves_validado}
                            echo "${self.private_key_pem}"      > ${local.nombre_fichero_private_pem}
                            echo "${self.private_key_openssh}"  > ${local.nombre_fichero_private_openssh}
                            echo "${self.public_key_pem}"       > ${local.nombre_fichero_public_pem}
                            echo "${self.public_key_openssh}"   > ${local.nombre_fichero_public_openssh}
                      EOT
    }
}































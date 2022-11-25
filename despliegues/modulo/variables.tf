variable "algoritmo"{
    type            =   object({
                            nombre          =   string
                            configuracion   =   optional(string, null)
                        })
    description     =   "Algoritmo a utilizar para la generación de las claves publica y privada"
    default         =   {
                            nombre          =   "RSA"
                            configuracion   =   "2048"
                        }
    validation  {
        condition       =   contains( ["RSA", "ECDSA", "ED25519"], var.algoritmo.nombre )
        error_message   =   "Algoritmo no válido. Debe ser uno de: RSA, ECDSA, ED25519"
    }
    
    validation  {
        condition       =   ( var.algoritmo.nombre != "RSA" 
                                                        ? true
                                                        : ( can(tonumber(var.algoritmo.configuracion)) 
                                                            ? tonumber(var.algoritmo.configuracion) > 0
                                                            : false ) 
                            )
        error_message   =   "Configuración inválida para el algoritmo RSA: Debe indicar un número"
    }
    
    validation  {
        condition       =   ( var.algoritmo.nombre != "ECDSA" 
                                                        ? true
                                                        : contains( ["P224", "P256", "P384", "P521"], var.algoritmo.configuracion )
                            )
        error_message   =   "Configuración inválida para el algoritmo ECDSA: Debe ser uno de: P224, P256, P384, P521"
    }
    
    validation  {
        condition       =   ( var.algoritmo.nombre != "ED25519" 
                                                        ? true
                                                        : var.algoritmo.configuracion == null
                            )
        error_message   =   "Configuración inválida para el algoritmo ED25519: Debe dejarse sin asignar"
    }

}

variable "directorio_claves" {
    type                =   string
    description         =   "Directorio donde almacenar/leer los ficheros de las claves"
    default             =   "."
    validation  {
        condition       =   length(regexall("^((([.]{1,2}[\\/])|[\\/])?([a-zA-Z0-9_-]+[\\/]?))|[.]+$", var.directorio_claves )) == 1
        error_message   =   "Directo no válido"
    }
}

variable "forzar_recreacion"{
    type        =   bool
    description =   "Recrear las claves aunque existan previamente"
    default     =   false
}
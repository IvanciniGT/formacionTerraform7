
variable "quieres_balanceador" {
  type      = bool
  default   = true
}

variable "numero_contenedores" {
  type      = number
  default   = 4
}

# Esta solución esta guay.... si es lo que necesito

# Si necesito que cada contenedor tengo un determinado nombre 
# y que cada contenedor exponga en un puerto concreto, esto no vale
variable "contenedores_personalizados" {
    type        = map(number)
    default     = {
                    "contenedor1" = 8090
                    "contenerorA" = 9090
                    "contenedorFederico" = 10000
                }
}

variable "contenedores_mas_personalizados" {
    type        = map(object({
                                puerto  =   number
                                ip      =   string
                             }))
    default     = {
                    "contenedorP1" = {
                                        puerto  =   8091
                                        ip      =   "127.0.0.1"
                                     }
                    "contenedorP2" = {
                                        puerto  =   8092
                                        ip      =   "127.0.0.1"
                                     }
                  }
}

variable "contenedores_mas_personalizados_2" {
    type        = list(object({
                                nombre  =   string
                                puerto  =   number
                                ip      =   string
                             }))
    default     = [
                      {
                            nombre  =   "contenedorP21"
                            puerto  =   8092
                            ip      =   "127.0.0.1"
                      },
                      {
                            nombre  =   "contenedorP22"
                            puerto  =   8092
                            ip      =   "127.0.0.1"
                      }
                  ]
}
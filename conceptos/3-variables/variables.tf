variable "nombre_contenedor" {
    type            = string
    description     = "Nombre del contenedor"
}
variable "cuota_de_cpu" {
    type            = number
    description     = "Cuota para la CPU del contenedor"
    #default         = 1024 # ESTO NO SE HACE NUNCA EN LOS SCRIPS !
                            # 1º Estos archivos son jodidos ... muy jodidos
                            # 2º Porque hay un sitio mejor !
}
variable "variables_entorno_contenedor" {
    type            = set(string)
    description     = "Variables de entorno"
}
variable "imagen_repo" {
    type            = string
    description     = "Repo de la imagen del contenedor"
}
variable "imagen_tag" {
    type            = string
    description     = "Tag de la imagen del contenedor"
}
variable "puertos_expuestos" {
    type            = list(map)
}
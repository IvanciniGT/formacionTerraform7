
output "direccion_ip" {
  value   = docker_container.miapache.network_data[0].ip_address
}
output "informacion_red" {
  value   = docker_container.miapache.network_data
}

# Los outputs los puedo sacar a posteriori con el comando:
# $ terraform output "nombre_de_output"
# El valor sale en sintaxis HCL
# Pero puedo pedirla en JSON y en modo RAW (plana), a traves de los parametros --json --raw
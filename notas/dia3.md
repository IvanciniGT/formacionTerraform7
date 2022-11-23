# Provisionadores

En terraform hay 3 tipos de provisionadores... antes había más.. hoy en día no. SOLO 3

## local-exec

Permiten ejecutar comandos en el entorno donde se ejecuta terraform cuando un recurso
es (creado o modificado) o (eliminado)

> 

## remote-exec

Permiten ejecutar comandos dentro de un recurso cuando el recurso
es (creado o modificado) o (eliminado)

> CASI NADA !... si puedo NADA !
Ejecutar un script... que haga cosas ... y ese script si puedo... que haga nada... o lo minimo posible
> Instalar python si no está... yo que se... pa que entre el ansible
> Instalar agente de puppet .... para que el puppet lo configure

## file

Permite copiar archivos al recurso cuando el recurso
es (creado o modificado) o (eliminado)

---

Creo un server nuevo con terraform...
- Le quiero crear usuarios                  |
- Le quiero instalar paquetes               |   Ansible, puppet, chef
- Le quiero configurar firewall local       |
- Le quiero configurar volumenes            |
# Qué es un contenedor

Es un entorno aislado dentro de un so con "kernel Linux" donde ejecutar procesos.
Entorno aislado en cuanto a que?
- Tiene su propia configuración de red -> su(s) propia(s) IP(s)
- Tiene su propio Sistema de archivos
- Tiene sus propias variables de entorno
- Puede tener limitaciones de acceso al hardware

Puedo ejecutar contenedores en windows? o en macos? o en otros unix? NO, imposible ! no hay manera real!
En windows podemos instalar cosas como DockerDesktop para Windows:
    - En versiones anteriores, montaba una maquina virtual con hyperV donde corrian los contenedores
    - Hoy en dia con el wls2, hay una capa de mapeo entre las funciones del kernel de linux y las de windows
En MacOS, también está disponible DockerDesktop, que también genera una maquina virtual, donde corren los contenedores.

Dentro de un contenedor NO SE EJECUTA UN SISTEMA OPERATIVO. UN CONTENEDOR USA EL SISTEMA OPERATIVO DEL HOST.
Esta es la gran diferencia con respecto a las máquinas virtuales.
Los contendores NO EJECUTAN Sistemas Operativos!

Los contenedores los creamos desde IMAGENES DE CONTENEDOR. QUE NUNCA LLEVAN DENTRO UN SISTEMA OPERATIVO.

Los procesos que se ejecutan dentro de un contenedor se ejecutan en segundo plano como si fuera un servicio. 
A nivel de kernel, los recursos son delimitados por namespaces mediante los cgroups

# Qué es una imagen de contenedor?

Una imagen de contenedor es un archivo comprimido (tar) que incluye un software YA INSTALADO Y PRECONFIGURADO por alguien, que supuestamente sabe MUCHO MAS QUE YO de cómo instalar ese software.
Adicionalmente se pueden incluir en ese archivo comprimido otros programas y comandos que puedan ser de utilidad.

Las imagenes de contenedor las obtenemos de registries de repositorios de imagenes de contenedor. El más famoso:
- Docker hub
- Quay.io       Redhat
---

Imaginad que quiero montar SQL Server en mi windows!
Qué necesito hacer?
1- Descargar un INSTALADOR de SQL Server
2- Ejecutar ese instalador + configuración
3- Ejecutar el software

Instalo SQL Server ---> C:\Archivos de programa\SQLServer >>>> ZIP ---> email 
                                                                En el mundo de los contenedores SI
                                                                Ese ZIP es una imagen de contenedor
---
Tipos de software
- Sistema operativo
- Aplicación                Como un software que corre en primer plano, que interactua con el usuario, 
                            y que se ejecuta de forma indefinida en el tiempo.
---------------------------------------------------------------------------------------------------vvvvvv
- Demonios
    - Servicio
- Driver
- Biblioteca/Libreria
- Comando
- Script



# Instalación tradicional a Hierro

     App1 + App2 + App3            Inconvenientes: 
    ---------------------               Incompatibilidades dependencias
           SO                           Incompatibildiades de configuración del SO
    ---------------------               Seguridad
          HIERRO                        Que pasaría si App1 tiene un bug (CPU 100%) App1 OFFLINE
                                                                                    App2 OFFLINE
                                                                                    App3 OFFLINE

# Trabajar con Maquinas Virtuales

    ---------------------           Inconvenientes:
      App1 |  App2 + App3               Desperdicio de recursos
    ---------------------               Empeoramiento del rendimiento de la app  
      SO1  |     SO2                    Configuración mucho más compleja de montar y mantener
    ---------------------               
      MV1  |     MV2
    ---------------------               
     HYPERVISOR:
     VMWare, VirtualBox, 
     KVM,Citrix, HyperV
    ---------------------               
           SO                           
    ---------------------               
          HIERRO                        

# Trabajar con Contenedores

    ---------------------           
      App1 |  App2 + App3           
    ---------------------               
      C1   |     C2
    ---------------------               
     Gestor de contenedores:
     Docker, Podman, 
     CRIO, containerD
    ---------------------               
           SO Linux                          
    ---------------------               
          HIERRO                        

Kubernetes / Openshift (Distro de Kubernetes de REDHAT) / TAMZU (Distro de Kubernetes de VMWARE): 
Son orquestadores de gestores de contenedores
    Cluster de Kubernetes
        Maquina 1
            CRIO
                MYSQL 1
                Apache 1
        Maquina 2
            CRIO
                Apache2
                Apache3
        Maquina N
            CRIO
                MYSQL 2

En entornos locales, de test y desarrollo se usa mucho DOCKER:
$ docker [TIPODEOBJETO] [VERBO] <args>
          container      list inspect start stop 
          image          pull
          network
          volume
          
        docker container list               docker ps
        docker image list                   docker images
        docker container start              docker start
        docker image pull                   docker pull
        
        
---

En mi host...
Cuántas interfaces de red -> IPs tengo?
    ipconfig
    ifconfig

    - Eth -> 172.31.30.185
    - Loopback -> 127.0.0.1 (localhost)
    - Docker   -> 172.17.0.1
    
---

Un contenedor puede ofrecer un servicio a través de un puerto: 172.17.0.1


        -------------RED DE AMAZON --------------------------
        |                                                   |
        172.31.30.185                                   ?????????
        |            :8080 -> nginx:80                      |
        IvanPC -- 127.0.0.1 : 8080-> nginx:80            MenchuPC
         |
         172.17.0.1 :8080 -> nginx:80
         |
         docker - 172.17.0.2 : 80 nginx


# Sistema de archivos de un contenedor:

Se monta mediante la superposicion de distintas capas(directorios)
/
    bin/
    opt/
    var/
        lib/
            docker/
                    containers/
                            .../
                                mysql/
                                        var/
                                            mysql/
                                                    Archivos de la BBDD
                    images/
                            ../
                                mysql/                                          chroot
                                        bin/
                                        opt/
                                        var/
                                        etc/
                                        tmp/
                                        usr/
                                        home/
                                        root/
    etc/
    tmp/
    usr/
    home/
        datos/mysql/ -> /var/mysql
    root/

VOLUMEN
CAPA CONTENEDOR: Con los cambios sobre los archivos que venían en la imagen
CAPA BASE: CAPA DE LA IMAGEN DEL CONTENEDOR: Inmutable

# Imagenes de contenedor:

En contenedores, las imagenes se identifican mediante un repo:tag

Existen tags variables:
    latest -> Apunta a la última versión del repo                   <<<<< PROHIBIDO EN ENTORNO DE PROD
    1      -> Apunta a la última versión 1                          <<<<< Me fio poco  !!!!! !
    1.21   -> Apunta a la última versión 1.21                       <<<<< EN PRODUCCION GENIAL !!!!! !
    1.21.7 -> Apunta a una versión concreta                         <<<<< EN PRODUCCION TAMPOCO !
    

1.21.7

1   Mayor       Se incrementa cuando hay cambios grandes de diseño que podrían 
                    provocar no retrocompatibilidad con versiones anteriores
21  Minor       Se incrementa cuando se aumenta funcionaliadad
7   Micro       Se incrementa al arreglar bugs


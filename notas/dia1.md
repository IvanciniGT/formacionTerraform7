# Terraform

Es una herramienta que fabrica una empresa llamada HashiCorp (Vagrant) que nos ofrece:
- Un lenguaje DECLARATIVO, llamado HCL (HashiCorp Language)
- Un intérprete con el que realizar comandos basados en scripts que montemos con ese lenguaje

Uso:
- Para gestionar (adquirir, liberar, mantener) recursos que contratamos (que nos ofrecen) unos proveedores.

Recursos:                                                       Proveedores:
- Máquinas virtuales                                            - Cloud
- Snapshots                                                     - Cluster de Kubernetes
- Redes privadas virtuales                                      - Servidor DNS
- Balanceadores de carga                                        - Active directory
- Claves SSH
- Un despliegue de Kubernetes
- Un usuario dentro de un Identity Provider (Active directory)
- Una entrada en un DNS server

El principal uso de terraform es la creación de Infraestructura dentro de Clouds!

## Cloud?

Conjunto de Servicios (normalmente relacionados con el mundo TIC) que una empresa ofrece a través de Internet:
- Alquiler de servicios: El pago de esos servicios es POR USO
- Los servicios se ofrecen de forma automatizada y desatendida. No hay ninguna persona detrás.

Clouds importantes:
    1º AWS                      Amazon
    2º Azure                    Microsoft
    3º Google Cloud Platform    Google

Los servicios que ofrecen los clouds, los dividimos en 3 grandes tipos:
- Infraestructura   (almacenaminto, cómputo, comunicaciones)                -   IaaS
- Plataform         (bases de datos, kubernetes-openshift, cluster spark)   -   PaaS
- Software          (apis, Cloud9)                                          -   SaaS

### Son importantes a día de hoy los clouds?

#### Qué características debe cumplir un entorno de producción de las que adolecen otros entornos:

- Alta disponibilidad
    Intentar asegurar que los servicios están operativos un tiempo determinado (preestablecido contractualmente)
        90% = 36 dias al año    OFFLINE     |   €
        99% = 3,5 días al año   OFFLINE     |   €€
        99,9% = 8 horas al año  OFFLINE     |   €€€€€€
        99,99% = minutos al año OFFLINE     v   €€€€€€€€€€€€€€€
            REDUNDANCIA
    Intentar asegurar la NO PERDIDA DE INFORMACION: x3

- Escalabilidad
    Capacidad de ajustar la infraestructura a las necesidades de cada momento:
        App3:   Este es el día de HOY : INTERNET
            Horas n          100 usuarios         Escalabilidad vertical:  Más máquina!
            Horas n+1        1000000 usuarios     Escalabilidad Horizontal: Más máquinaS!!!
            Horas n+2        0 usuarios
            Horas n+3        20000000 usuarios    
                                                    Quien me ofrece estaforma de trabajar? CLOUDs

Queremos estar creando y borrando máquinas a mano? NO
    Esto es lo que vamos a automatizar con Terraform !

---

# DEV ---> OPS

Qué es DEVOPS? Anterior al 2010

Devops es una filosofía, cultura, prácticas que muchas empresa están implementando.
DEVOPS: AUTOMATIZACION 

Queremos automatizar todos los trabajos que existen entre el desarrollo y operación de un sistema:
                        AUTOMATIZABLE       HERRAMIENTAS            QUIEN ? 
PLAN                            x
CODE                            x
BUILD                           √           maven, gradle, sbt,     Desarrollador
                                            nuget, dotnet, ant
TEST                            
    diseño                      x
    ejecución                   √           selenium, soapui,       Tester v2.0 (programadores)
                                            postman, karate, jmeter, 
                                            loadrunner, sonarqube
        Las hago en la máquina del desarrollador?   NO - No me fio de esas máquinas ... están muy maleadas
        Las hago en la máquina del tester?          NO /        Las pruebas en un entorno LIMPIO Y CONTROLADO !
    
    Y si no tengo el entorno?
        A adquirilo..
            - comprarlo                                                 Sistemas
            - alquilarlo                                                Sistemas
            - Crear una MV dentro de mi infra VMWare                    Sistemas
                                √           terraform, vagrant
    Hay que instalar en ese entorno limpio y controlado. Quién me ayuda? Es automatizable?
                                √           docker, kubernetes, 
                                            ansible, puppet
                                            -> script bash, sh, ps1     Sistemas
        
            Me fio del entorno de test/Preproducción/QA/Entorno de Integración para hacer las pruebas? 
                    NO... porque estará maleado igual
                    El dia 1 no...  pero después de 5 meses instalando alli mierda... 
                                    el entorno está pa' tirarlo a la basura
            La tendencia a día de hoy? 
                    Cada vez que tengo que hacer pruebas quiero un entorno nuevo, limpio, de 0.
            
            Es más, quiero mantener ese entorno arriba, consumiendo luz, recursos, etc, mientras no se usa? Ni de coña!
    <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<     Integración continua    Continuous integration  -   CI
RELEASE                         
    <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<     Entrega continua        Continuous delivery     \
DEPLOYMENT                                                                                      CD
    <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<     Despliegue continua     Continuous Deployment   /
MONITOR
OPERATION

Aquí falta una cosa por automatizar... cuál?
Quién llama a todos esos programas? YO? dandole ahí al play?
    Servidor de automatización: Jenkins, AzureDevops, TravisCI, Bamboo, TeamCity, Gitlab CI/CD, Github actions

    Ésta es una herramienta nueva, que antes no hacía falta. Quién la configura?    Al devops!
        Requiere conocer todas esas herramientas. No las voy a configurar

Realmente DEVOPS no es un perfil, ni una persona.

---
# Lenguaje DECLARATIVO, llamado HCL (HashiCorp Language)

Lenguaje? 
- Gramática     ***
- Sintaxis      ***
- Semántica     *   Las palabras más importantes de terraform. 50 palabras!      

DECLARATIVO? 
IF hay algo que no es una silla, quitalo primero
IF no hay silla, vete al ikea y compra una silla!
IF  no hay silla debajo de la ventana
    Tú! pon la silla debajo de la ventana > Imperativo
        No nos gustan porque nos comemos NOSOTROS la responsabildiad del COMO hay que hacer el trabajo.

Tu! Quiero una silla debajo de la ventana > Desiderativo. ESTO ES LO QUE LLAMAMOS DECLARATIVO!!!
    Aquí el cómo lo determina felipón! NO YO .


Todas las herramientas que triunfan a día de hoy usan lenguaje DECLARATIVO:
- Terraform
- Kubernetes
- Ansible
- Docker compose usa lenguaje declarativo, docker no... es imperativo

Puedo automatizar la creación de infraestructuras o de cualquier otro 
tipo de servicio en AWS sin necesitar terraform?    SI..... con el aws cli      > Imperativo

Puedo automatizar la creación de infraestructuras o de cualquier otro 
tipo de servicio en AZURE sin necesitar terraform?  SI..... con el azure cli    > Imperativo (el mismo que se usa en un scrip bash, ps1)

Para qué, por qué quiero terraform? 
    Terraform me sirve para todos.....  SI... pero cada uno el suyo.
        Significa esto que un script en el que defina una infra (Quiero 3 máquians + RED + x espacio de almacenamiento)
        que haga para Amazon me sirve para Azure también? NO
    Por que tengo un lenguaje DECLARRATIVO

En este concepto... qué vamos a tener en un script de terraform?
Qué es al final un script de terraform?
    Lista de deseos de "recursos"
    Carta a los reyes magos
    Catalogo de mi infraestructura deseada
    
Voy a escribir un fichero de texto que contiene una descripción de mi infraestructura: INFRAESTRUCTURA COMO CODIGO

Terraform, puede comprobar si lo que tienes en el script:
- Ya está creado? SI / NO / PARTE
- Me puede calcular lo que es necesario HACER para conseguir exactamente lo que necesito

## Scripts de terraform 

Un script de terraform es una carpeta que tiene un conjunto de archivos con extensión .tf, 
cuyos nombres son COMO YO QUIERA, A TERRAFORM LE DA IGUAL.
Hay ciertos convenios, que son solo convenios. (OJO: ES IMPORTANTE SEGUIR LOS CONVENIOS)

El conjunto de ficheros con extensión .tf que haya dentro de una carpeta, es lo que se llama un SCRIPT de TERRAFORM.

Esos ficheros se escriben con lenguaje HCL, que en apariencia (sintaxis) es una mezcla de JSON y YAML
                                                                                           {}    No necesidad de usar continuamente comillas para todo y comas

Hay unos cuantos bloques (palabras importantes) que son los que vamos a utilizar en estos ficheros:
- terraform         Martes
- provider          Martes
- resource          Martes
- output            Martes
- variable          Martes, Miercoles   *** ES LO MAS COMPLEJO DE TERRAFORM CON MUCHA DIFERENCIA !
- ---------- ^ No vamos a tocar ni un cloud
- ---------- v Empezaremos a jugar con clouds
- locals            JUEVES
- module            JUEVES , VIERNES    *** ESTO ES LO MAS IMPORTANTE DE TERRAFORM 
- data              VIERNES 


## Interprete de terraform: CLI

El interprete de terraform se llama: "terraform"

### Comandos / Ciclo de vida de un script/proyecto terraform

- init              Descargar del terraform registry los proveedores que se hayan declarado
- validate          Valida la sintaxis de un script terraform
- plan              Nos indica las tareas necesarias para conseguir que mi entorno/infra coincida con la que
                    tengo definida (declarada) en mi script
- apply             Aplicar el plan... y por ende... Crear infraestructura?  √
                                                     Borrar infraestructura? √   
                                                     Modificar infraestructura? √
- destroy           Borrar toda la infraestructura

# Providers de terraform

Los encontramos en el terraform registry.

Qué es un provider?

Es un programa que puede ser invocado por terraform, 
para comunicarse con el que sea que vaya a proveerme de mis recursos.

    Script terraform    ---> terraform  ----->  proveedor  ----> cli AWS ---> AWS
        declararemos                               aws              ^
        que necesitamos el proveedor de aws                    CREDENCIALES

Con cuantos providers distintos se distribuye terraform? NINGUNO !
De hecho, en cada proyecto, usaré unos proveedores distintos.




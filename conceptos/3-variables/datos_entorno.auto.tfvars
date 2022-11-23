cuota_de_cpu                    = 4096
nombre_contenedor               = "miapache"
variables_entorno_contenedor    = [
                                        {
                                            clave   =  "VARIABLE1"
                                            valor   =  "valor1"
                                        },
                                        {
                                            clave   =  "VARIABLE2"
                                            valor   =  "valor2"
                                        },
                                        {
                                            clave   =  "VARIABLE3"
                                            valor   =  "valor3"
                                        }
                                  ]
                                  # Con esta solución hemos arrglado la magia de los signos igual
                                  # Y también posibles ambigüedades en la forma en la que dar los datos
                                  # De donde sale que haya que poner "NOMBRE=VALOR"
imagen_repo                     = "httpd"
imagen_tag                      = "latest"
puertos_expuestos               = [
                                        {
                                            interno =   80000
                                            externo =   8081
                                        },
                                        {
                                            interno =   443
                                            externo =  8444
                                        }
                                  ]
                                  
# Esto está guay !!!!!!! Repetir externo / interno todo el rato esta REQUETE GUAY !!!!
# Please SIEMPRE EXPLICITO !!! NO QUIERO OTRA MANERA 
# Aun así,  el tipo que hemos definido NO LO QUEREMOS !

#puertos_expuestos               = [ [80,8080], [443,8443] ]
# Aqui no repito . NUNCA IMPLICITO.... NI DOCUMENTADO 
#puerto_http                     = [80, 8080]
#puerto_http_interno             = 80
#puerto_http_externo             = 8080


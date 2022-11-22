cuota_de_cpu                    = 333
nombre_contenedor               = "miapache"
variables_entorno_contenedor    = [
                                  "VARIABLE1=valor1",
                                  "VARIABLE2=valor2"
                                  ]
imagen_repo                     = "httpd"
imagen_tag                      = "latest"
puertos_expuestos               = [
                                        {
                                            interno =   80
                                            externo =   8080
                                        },
                                        {
                                            interno =   443
                                            federico =   8443
                                        }
                                  ]
# Esto está guay !!!!!!! Repetir externo / interno todo el rato esta REQUETE GUAY !!!!
# Please SIEMPRE EXPLICITO !!! NO QUIERO OTRA MANERA 
# Aun así,  el tipo que hemos definido NO LO QUEREMOS !

puertos_expuestos               = [ [80,8080], [443,8443] ]
# Aqui no repito . NUNCA IMPLICITO.... NI DOCUMENTADO 
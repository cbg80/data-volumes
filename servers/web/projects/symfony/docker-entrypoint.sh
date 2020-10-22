#!/bin/bash
#instala symfony en un directorio a modo de borrador
composer -vvv create-project symfony/framework-standard-edition $1 --no-interaction
#copia el contenido de aquel al directorio raíz de la aplicación
cp -Rfv $1/* $2
#borra el directorio borrador y todo su contenido
rm -Rfv $1
#Se situa en el directorio raíz de la aplicación desplegada
cd $2
#Elimina de la aplicación todo el código correspondiente a las dependencias de aquella
#rm -Rfv ./vendor
#Vuelve  a importar el código correspondiente a las dependencias de la aplicación
#composer install
#Actualiza el código correspondiente a las dependencias de la aplicación
composer -vvv update
# The last IP address in the array is got from /var/log/apache2/symfony-draft.cbg/access.log. It stands for the IP address of the box 
# that hosts the symfony web app container. This way the symfony web app is supposed to be run in a DEV environment.
sed -i -e "s/'127.0.0.1', '::1'/'127.0.0.1', '::1', '172.17.0.1'/" web/app_dev.php
sed -i -e "s/'::1'/'::1',\n    '172.17.0.1'/" web/config.php
# Sets up some database related parameters
sed -i -e "s/database_host: 127.0.0.1/database_host: '%env(MARIADB_PORT_3306_TCP_ADDR)%'/" app/config/parameters.yml
sed -i -e "s/database_port: null/database_port: 3306/" app/config/parameters.yml
sed -i -e "s/database_name: symfony/database_name: ImageThread/" app/config/parameters.yml
sed -i -e "s/database_password: null/database_password: '%env(MARIADB_ENV_MYSQL_ROOT_PASSWORD)%'/" app/config/parameters.yml
#including the character set and collation
sed -i -e "s/charset: UTF8/charset: utf8mb4  #Replaces UTF8\n        default_table_options:\n            charset: utf8mb4\n            collate: utf8mb4_unicode_ci/" app/config/config.yml
#decoupling the specific app configuration from symfony configuration
echo "image_thread:" >> app/config/routing.yml
echo "    resource: '@AppBundle/Resources/config/routing.yml'" >> app/config/routing.yml
#activating the serializer
sed -i -e "s/#serializer: { enable_annotations: true }/#serializer: { enable_annotations: true }\n    serializer: { enabled: true }/" app/config/config.yml
#importing the service configuration specific for the app
sed -i -e "s/- { resource: services.yml }/- { resource: services.yml }\n    - { resource: '@AppBundle\/Resources\/config\/services.yml' }/" app/config/config.yml
#Elimina de la aplicación todos los recursos correspondientes a la documentación de esta
#rm -Rfv ./doc
#Vuelve a generar todos los recursos correspondientes a la documentación de la aplicación
#./vendor/bin/phpdoc -d . -t ./doc --template="responsive" --title="$3" --sourcecode --ignore "vendor/*"
#Asigna al usuario apache como propietario de todo el contenido de la aplicación
chown -R www-data:www-data 	./
#Asigna los permisos adecuados a todos los ficheros que constituyen la aplicación. Las dos siguientes líneas son mutuamente excluyentes. 
#La primera estará descomentada a la hora de desplegar un entorno de desarrollo. La segunda estará descomentada a la hora de desplegar 
#un entorno de producción
chmod -R 0664 ./
#chmod -R 0444 ./
#Asigna los permisos adecuados a todos los directorios que constituyen la aplicación. Las dos siguientes líneas son mutuamente excluyentes. 
#La primera estará descomentada a la hora de desplegar un entorno de desarrollo. La segunda estará descomentada a la hora de desplegar 
#un entorno de producción
find ./ -type d -iname "*" -print0 | xargs -I {} -0 chmod 0774 {}
#find ./ -type d -iname "*" -print0 | xargs -I {} -0 chmod 0544 {}
#La siguiente línea sólo será descomentada a la hora de desplegar un entorno de producción
#chmod -R 0744 ./assets/
#Asigna al superusuario como propietario del comando generador de la documentación de la aplicación
#chown root:root ./vendor/bin/phpdoc
#Asigna los permisos adecuados al comando generador de la documentación de la aplicación
#chmod 0744 ./vendor/bin/phpdoc
#arranca el servidor web
$4 $5 $6
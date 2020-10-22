FROM debian:8.7
MAINTAINER Carlos Blanco <carlos.blanga@gmail.com>
ENV LANG es_ES.UTF-8
ENV TZ Europe/Madrid
RUN apt-get update && \
	apt-get --assume-yes install locales && \
	sed -i -e "s/# $LANG.*/$LANG UTF-8/" /etc/locale.gen && \
	locale-gen && \
	update-locale $LANG && \
	ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
	echo $TZ > /etc/timezone
ENV DR /var/www/html
#cambiar en función del proyecto a desplegar#
#ARG REMOTE_DIR=symfony-draft.cbg
ARG REMOTE_DIR=image-thread.cbg
#ARG LOCAL_DIR=SymfonyDraft
ARG LOCAL_DIR=SymfonyImageThread
#FIN cambiar en función del proyecto a desplegar#
ADD ./$LOCAL_DIR/config/$REMOTE_DIR.conf /etc/apache2/sites-available/$REMOTE_DIR.conf
RUN apt-get update && \
	apt-get --assume-yes upgrade && \
	apt-get --assume-yes install apache2 && \
	sed -i -e "s/#AddDefaultCharset UTF-8/AddDefaultCharset UTF-8/" /etc/apache2/conf-available/charset.conf && \
	update-rc.d apache2 defaults && \
	mkdir $DR/foo && \
	mkdir $DR/$REMOTE_DIR && \
	mkdir -p /var/log/apache2/$REMOTE_DIR/ && \
	a2ensite $REMOTE_DIR.conf && \
	apt-get --assume-yes install wget && \
	apt-get --assume-yes install apt-transport-https lsb-release ca-certificates && \
	wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
	echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list && \
	apt-get update && \
	apt-get --assume-yes install php7.1 libapache2-mod-php7.1 libapache2-mod-php7.1-dbgsym php-xdebug \
			php7.1-cgi php7.1-cgi-dbgsym php7.1-cli php7.1-cli-dbgsym php7.1-common php7.1-common-dbgsym \
			php7.1-curl php7.1-curl-dbgsym php7.1-fpm php7.1-fpm-dbgsym php7.1-gd php7.1-gd-dbgsym \
			php7.1-intl php7.1-intl-dbgsym php7.1-json php7.1-json-dbgsym php7.1-mbstring \
			php7.1-mbstring-dbgsym php7.1-mysql php7.1-mysql-dbgsym php7.1-readline php7.1-readline-dbgsym \
			php7.1-xml php7.1-xml-dbgsym php7.1-zip php7.1-zip-dbgsym \
			curl git && \
	apt-get --assume-yes --only-upgrade install php7.1 libapache2-mod-php7.1 libapache2-mod-php7.1-dbgsym \
			php-xdebug php7.1-cgi php7.1-cgi-dbgsym php7.1-cli php7.1-cli-dbgsym php7.1-common \
			php7.1-common-dbgsym php7.1-curl php7.1-curl-dbgsym php7.1-fpm php7.1-fpm-dbgsym php7.1-gd \
			php7.1-gd-dbgsym php7.1-intl php7.1-intl-dbgsym php7.1-json php7.1-json-dbgsym php7.1-mbstring \
			php7.1-mbstring-dbgsym php7.1-mysql php7.1-mysql-dbgsym php7.1-readline php7.1-readline-dbgsym \
			php7.1-xml php7.1-xml-dbgsym php7.1-zip php7.1-zip-dbgsym && \
	a2enmod proxy_fcgi setenvif && \
	a2enconf php7.1-fpm && \
	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
	echo "xdebug.remote_enable=1" >> /etc/php/7.1/mods-available/xdebug.ini && \
	echo "xdebug.remote_host=172.17.0.1" >> /etc/php/7.1/mods-available/xdebug.ini && \
	apt-get update && \
	apt-get --assume-yes install graphviz && \
	apt-get clean
EXPOSE 80
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh && \
	echo "/usr/bin/php $DR/$REMOTE_DIR/bin/console cache:clear" > /symfony-dev-cache-cleaner.sh && \
	echo "chown -R www-data:www-data $DR/$REMOTE_DIR/var/cache/dev" >> /symfony-dev-cache-cleaner.sh && \
	echo "chmod -R 0774 $DR/$REMOTE_DIR/var/cache/dev" >> /symfony-dev-cache-cleaner.sh && \
#	echo "chmod -R 0664 $DR/$REMOTE_DIR/var/cache/dev" >> /symfony-dev-cache-cleaner.sh && \
#	echo "find $DR/$REMOTE_DIR/var/cache/dev -type d -iname "*" -print0 | xargs -I {} -0 chmod 0774 {}" >> /symfony-dev-cache-cleaner.sh && \
	chmod +x /symfony-dev-cache-cleaner.sh
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
#cambiar en función del proyecto a desplegar#
#ENTRYPOINT ["/docker-entrypoint.sh", "/var/www/html/foo", "/var/www/html/symfony-draft.cbg", "SymfonyDraft"]
ENTRYPOINT ["/docker-entrypoint.sh", "/var/www/html/foo", "/var/www/html/image-thread.cbg", "SymfonyImageThread"]
#FIN cambiar en función del proyecto a desplegar#
FROM debian:9
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
ARG LDRB=html_root
#cambiar en función del proyecto a desplegar#
ARG REMOTE_DIR=image-thread.cbg
ARG LOCAL_DIR=imageThread
#ARG REMOTE_DIR=image-thread-api.cbg
#ARG LOCAL_DIR=imageThreadAPI
#FIN cambiar en función del proyecto a desplegar#
ADD ./$LOCAL_DIR/config/$REMOTE_DIR.conf /etc/apache2/sites-available/$REMOTE_DIR.conf
RUN apt-get update && \
	apt-get --assume-yes upgrade && \
	apt-get --assume-yes install apache2 && \
	sed -i -e "s/#AddDefaultCharset UTF-8/AddDefaultCharset UTF-8/" /etc/apache2/conf-available/charset.conf && \
	update-rc.d apache2 defaults && \
	mkdir -p $DR/$REMOTE_DIR/$LDRB && \
	mkdir -p /var/log/apache2/$REMOTE_DIR/ && \
	a2ensite $REMOTE_DIR.conf && \
	a2dissite 000-default.conf && \
#	apt-get update && \
	apt-get --assume-yes install wget && \
	apt-get --assume-yes install apt-transport-https lsb-release ca-certificates && \
	wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
	echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list && \
	apt-get update && \
	apt-get --assume-yes install php7.4 libapache2-mod-php7.4 php-xdebug \
			php7.4-cgi php7.4-cli php7.4-common \
			php7.4-curl php7.4-fpm php7.4-gd \
			php7.4-intl php7.4-json php7.4-mbstring \
			php7.4-mysql php7.4-readline \
			php7.4-xml php7.4-zip php7.4-xsl \
			curl git && \
	#apt-get --assume-yes --only-upgrade install php7.4 libapache2-mod-php7.4 \
			#php-xdebug php7.4-cgi php7.4-cli php7.4-common \
			#php7.4-curl php7.4-fpm php7.4-gd \
			#php7.4-intl php7.4-json php7.4-mbstring \
			#php7.4-mysql php7.4-readline \
			#php7.4-xml php7.4-zip php7.4-xsl && \
	a2enmod proxy_fcgi setenvif && \
	a2enconf php7.4-fpm && \
	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
	echo "ServerName $REMOTE_DIR" >> /etc/apache2/apache2.conf && \
	echo "xdebug.remote_enable=1" >> /etc/php/7.4/mods-available/xdebug.ini && \
	echo "xdebug.remote_connect_back=1" >> /etc/php/7.4/mods-available/xdebug.ini && \
	apt-get update && \
	apt-get --assume-yes install graphviz unzip && \
	apt-get clean
WORKDIR $DR/$REMOTE_DIR/$LDRB
#esto es sólo necesario para el despliegue del proyecto ImageThreadAPI#
#RUN mkdir webapp_model && \
#	mkdir assets && \
#	mkdir webapp_controllers && \
#	mkdir webapp_utilities
#FIN esto es sólo necesario para el despliegue del proyecto ImageThreadAPI#
EXPOSE 80
ENV LDRB $LDRB
ENV REMOTE_DIR $REMOTE_DIR
ENV LOCAL_DIR $LOCAL_DIR
ENV DATABASE ImageThread
ENV REL_PATH_TO_POST_IMG assets/img
ENV REL_PATH_TO_VIEW_COUNTER_FILE assets/view_counter.dat
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
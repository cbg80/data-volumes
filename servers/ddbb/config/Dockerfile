FROM mariadb:latest
MAINTAINER Carlos Blanco Gañán <carlos.blanga@gmail.com>
ENV MYSQL_ROOT_PASSWORD root
RUN apt-get update && \
	apt-get --assume-yes install --only-upgrade mariadb-server
COPY ./mariadb.cnf /etc/mysql/conf.d/mariadb.cnf
EXPOSE 3306
CMD ["mysqld"]
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
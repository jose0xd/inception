FROM alpine:3.15.4

#EXPOSE 9000
ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_HOSTNAME

RUN apk update && \
	apk add --no-cache php7-fpm php7-mcrypt php7-soap \
	php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom \
	php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu \
	php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql \
	php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc \
	php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype

WORKDIR /var/www/

RUN mkdir /scripts
COPY conf/www.conf /var/www
COPY conf/create_wordpress.sh /scripts
RUN chmod +x /scripts/create_wordpress.sh
RUN /scripts/create_wordpress.sh

CMD ["php-fpm7", "-F"]

FROM alpine:3.15.4

#EXPOSE 3306
ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_ROOT_PASSWORD

RUN apk update && \
	apk add --no-cache mariadb mariadb-client && \
	addgroup mysql mysql && \
	mkdir /scripts

COPY conf/wordpress.sql /scripts/wordpress.sql
COPY conf/install_db.sh /scripts/startup.sh
RUN chmod +x /scripts/startup.sh

ENTRYPOINT ["/scripts/startup.sh"]

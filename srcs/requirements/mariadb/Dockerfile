FROM alpine:3.15.4

EXPOSE 3306

RUN apk update && \
	apk add --no-cache mariadb mariadb-client && \
	addgroup mysql mysql && \
	mkdir /scripts

COPY conf/install_db.sh /scripts/startup.sh
RUN chmod +x /scripts/startup.sh

ENTRYPOINT ["/scripts/startup.sh"]

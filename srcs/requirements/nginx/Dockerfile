FROM alpine:3.15.4

EXPOSE 443

RUN apk update && \
	apk add --no-cache nginx openssl

RUN openssl req -newkey rsa:4096 \
		-x509 -sha256 -days 3650 -nodes \
		-out /etc/ssl/jarredon.42.fr.pem \
		-keyout /etc/ssl/jarredon.42.fr.key \
		-subj "/C=ES/ST=Andalucia/L=Malaga/O=42 School/OU=./CN=."

COPY conf/default.conf /etc/nginx/http.d

CMD ["nginx", "-g", "daemon off;"]

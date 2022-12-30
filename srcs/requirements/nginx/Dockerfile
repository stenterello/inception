FROM		alpine:3.13.6

RUN		apk add --no-cache nginx openssl

RUN		mkdir /etc/nginx/ssl
RUN		mkdir /run/nginx

COPY		conf/nginx.conf /etc/nginx/conf.d/

RUN		openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes \
		-keyout /etc/nginx/ssl/ddelladi.key \
		-out	/etc/nginx/ssl/ddelladi.pem \
		-subj   "/C=IT/ST=Italy/L=Rome/O=42 Rome/OU=ddelladi/CN=ddelladi/"

ENTRYPOINT	["nginx", "-g", "daemon off;"]

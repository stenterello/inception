FROM		alpine:3.13.6

RUN			apk add --no-cache nginx openssl

RUN			mkdir /etc/nginx/ssl && mkdir /run/nginx && mkdir -p /var/www/html/wordpress && mkdir -p /var/log/custom_logs/nginx && touch /var/log/custom_logs/nginx/access.log /var/log/custom_logs/nginx/error.log

COPY		conf/nginx.conf			/etc/nginx/http.d/
ADD			conf/static				/tmp/
COPY		tools/configure.sh		/tmp/

RUN			openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes \
			-keyout /etc/nginx/ssl/ddelladi.key \
			-out	/etc/nginx/ssl/ddelladi.pem \
			-subj   "/C=IT/ST=Italy/L=Rome/O=42 Rome/OU=ddelladi/CN=ddelladi/"

ENTRYPOINT	[ "sh", "/tmp/configure.sh" ]

FROM		alpine:3.13.6

RUN 		apk update && apk upgrade && apk add --no-cache \
    		php$7 \
    		php$7-common \
    		php$7-session \
    		php$7-iconv \
    		php$7-gd \
    		php$7-curl \
    		php$7-xml \
    		php$7-mysqli \
    		php$7-imap \
    		php$7-cgi \
    		php$7-pdo \
    		php$7-pdo_mysql \
    		php$7-soap \
    		php$7-posix \
    		php$7-gettext \
    		php$7-ldap \
    		php$7-ctype \
    		php$7-dom \
    		php$7-simplexml \
    		wget

RUN			wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql.php && mkdir -p /var/www/html/adminer && mv adminer-4.8.1-mysql.php /var/www/html/adminer/index.php

ENTRYPOINT [ "php", "-S", "0.0.0.0:8080", "-t", "/var/www/html" ]

FROM		alpine:3.13.6

RUN 		apk update && apk upgrade && apk add --no-cache \
    		php7 \
    		php7-common \
    		php7-session \
    		php7-iconv \
    		php7-gd \
    		php7-curl \
    		php7-xml \
    		php7-mysqli \
    		php7-imap \
    		php7-cgi \
    		php7-pdo \
    		php7-pdo_mysql \
    		php7-soap \
    		php7-posix \
    		php7-gettext \
    		php7-ldap \
    		php7-ctype \
    		php7-dom \
    		php7-simplexml \
    		wget

COPY		tools/configure.sh	/tmp/

ENTRYPOINT	[ "sh", "/tmp/configure.sh" ]

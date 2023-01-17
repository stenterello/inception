FROM		alpine:3.13.6

RUN			apk update && apk upgrade && apk add --no-cache openssh-server \
			git \
			git-daemon \
			openssl-dev \
			zlib-dev \
			gettext-dev \
			build-base \
			tar \
			xz \
			curl \
			fcgiwrap \
			spawn-fcgi \
			bash

RUN			adduser -S nginx && addgroup -S nginx

COPY		tools/configure.sh		/tmp/
COPY		tools/post-receive		/tmp/
COPY		conf/cgitrc				/etc/
COPY		conf/spawn-fcgi.cgit	/etc/conf.d/

ENTRYPOINT	[ "sh", "/tmp/configure.sh" ]

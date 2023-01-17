FROM		alpine:3.13.6

RUN			apk update && apk upgrade && apk add --no-cache openssh-server git cgit openssl-dev zlib-dev gettext-dev build-base tar xz curl fcgiwrap spawn-fcgi bash

RUN			adduser -S nginx && addgroup -S nginx

COPY		tools/configure.sh		/tmp/
COPY		tools/git_init.sh		/tmp/
COPY		conf/project-list.txt	/tmp/

ENTRYPOINT	[ "sh", "/tmp/configure.sh" ]

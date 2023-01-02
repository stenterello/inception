FROM	alpine:3.13.6

RUN		apk update && apk upgrade && apk add --no-cache mariadb mariadb-client

COPY	tools/configure.sh .

ENTRYPOINT	[ "sh", "configure.sh" ]

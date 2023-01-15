FROM		alpine:3.13.6

RUN			apk update && apk upgrade && apk add --no-cache redis

COPY		tools/configure.sh	/tmp/
COPY		conf/redis.conf		/tmp/

ENTRYPOINT	[ "sh", "/tmp/configure.sh" ]

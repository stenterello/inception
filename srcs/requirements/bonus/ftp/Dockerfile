FROM		alpine:3.13.6

RUN			apk update && apk upgrade && apk add --no-cache vsftpd

COPY		conf/vsftpd.conf	/tmp/vsftpd.conf
COPY		conf/banner.txt		/etc/vsftpd/banner.txt
COPY		tools/configure.sh	/tmp/configure.sh

RUN			touch /etc/vsftpd.allowed_users

ENTRYPOINT	[ "sh", "/tmp/configure.sh"]

#!/bin/bash


if [ ! -f "/etc/vsftpd/vsftpd.conf.bak" ]; then

	mkdir -p /var/www/html

	cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.bak
	mv /tmp/vsftpd.conf /etc/vsftpd/vsftpd.conf
	mkdir -p /var/log/custom_logs/ftp && touch /var/log/custom_logs/ftp/ftp.log
	adduser -D ${FTP_USER}
	cat << EOF | passwd ${FTP_USER}
${FTP_PWD}
${FTP_PWD}
EOF
	chown -R ${FTP_USER}:${FTP_USER} /var/www/html
	if [ `cat /etc/vsftpd.allowed_users | grep ${FTP_USER} | wc -l` -eq 0 ];
	then
		echo ${FTP_USER} >> /etc/vsftpd.allowed_users
	fi
fi

echo "FTP Starting"

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf

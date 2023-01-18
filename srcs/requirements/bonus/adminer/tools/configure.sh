#!/bin/sh

if [ ! -d "/var/www/html/adminer" ];
then
	wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql.php -O /tmp/index.php
	mkdir -p /var/www/html/adminer
	mv /tmp/index.php /var/www/html/adminer
fi

php -S 0.0.0.0:8080 -t /var/www/html/adminer

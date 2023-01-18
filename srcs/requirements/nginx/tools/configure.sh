#!/bin/bash

if [ -f "/tmp/index.html" ];
then
	mv /tmp/index.html	/var/www/html
	mv /tmp/css			/var/www/html
	mv /tmp/js			/var/www/html
fi

nginx -g 'daemon off;'

#!/bin/bash

mv /tmp/index.html	/var/www/html
mv /tmp/css			/var/www/html
mv /tmp/js			/var/www/html

nginx -g 'daemon off;'

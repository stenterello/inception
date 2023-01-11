#!/bin/bash

if [ ! -d "~/data" ];
then
	mkdir -p ~/data/wp_files ~/data/wp_database ~/data/nginx
fi

if [ `cat /etc/hosts | grep ddelladi.42.fr | wc -l` -eq 0 ];
then
	echo "127.0.0.1		ddelladi.42.fr" | sudo tee -a /etc/hosts
fi
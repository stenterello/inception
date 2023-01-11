#!/bin/bash

if [ ! -d "~/data"];
then
	mkdir -p ~/data/wp_files ~/data/wp_database ~/data/nginx
fi

if [ sudo bash -c "`cat /etc/hosts | grep ddelladi | wc -l` -eq 1" ];
then
	echo "127.0.0.1		ddelladi.42.fr" | sudo tee -a /etc/hosts
fi
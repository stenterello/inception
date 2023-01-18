#!/bin/bash


# SSH KEYS SETUP

if [ ! -f "/etc/ssh/ssh_host_rsa_key" ];
then
	ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
	ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
	ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key
fi


# SETUP GIT

if [ `cat /etc/passwd | grep git | wc -l` -eq 0 ];
then

	cat << EOF | adduser -g ddelladi -h /var/git git
${GIT_PWD}
${GIT_PWD}
EOF

	cat << EOF >> /etc/ssh/ssh_config
Match Group git
	AllowedKeysFile /var/git/.ssh/authorized_keys
EOF

	addgroup root git
	addgroup git git

fi


# CREATE SSH DIRECTORY

if [ ! -d "/var/git/.ssh" ];
then
	mkdir /var/git/.ssh
	chown git:git /var/git/.ssh
	chmod 760 /var/git/.ssh
	touch /var/git/.ssh/authorized_keys
	chown git:git /var/git/.ssh/authorized_keys
	chmod 660 /var/git/.ssh/authorized_keys
fi


# COMPILE AND SETUP CGIT

if [ ! -d "/var/www/html/cgit" ];
then
	mkdir -p /var/www/html/cgit
	git clone git://git.zx2c4.com/cgit
	cd cgit
	make get-git
	echo "CGIT_SCRIPT_PATH = /var/www/html/cgit/" > cgit.conf
	sed -i "29i #define REG_STARTEND\t00004" git/git-compat-util.h
	sed -i 's/\tCGIT_LIBS += -ldl/\tCGIT_LIBS += -ldl -lintl/' cgit.mk
	make
	make install
fi


# FCGIWRAP SETUP

if [ ! -f "/etc/init.d/spawn-fcgi.cgit" ];
then
	ln -s /etc/init.d/spawn-fcgi /etc/init.d/spawn-fcgi.cgit
	ln -s /usr/bin/spawn-fcgi /usr/bin/spawn-fcgi.cgit
fi

echo "Cgit starting"
/usr/bin/spawn-fcgi.cgit -n -a 0.0.0.0 -p 1234  /usr/bin/fcgiwrap

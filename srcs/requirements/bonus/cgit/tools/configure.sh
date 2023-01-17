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


# CREATE GIT BARE REPO AND SSH DIRECTORY

if [ ! -d "/var/git/inception.git" ];
then
	chown git:git /tmp/git_init.sh
	chmod 764 /tmp/git_init.sh
	/bin/bash -c '/tmp/git_init.sh' git
fi


# COMPILE AND SETUP CGIT

if [ ! -d "/var/www/html/cgit" ];
then

	if [ ! -d "/var/www/html/cgit" ];
	then
		mkdir -p /var/www/html/cgit
	fi
	git clone git://git.zx2c4.com/cgit
	cd cgit
	make get-git
	echo "CGIT_SCRIPT_PATH = /var/www/html/cgit/" > cgit.conf
	sed -i "29i #define REG_STARTEND\t00004" git/git-compat-util.h
	sed -i 's/\tCGIT_LIBS += -ldl/\tCGIT_LIBS += -ldl -lintl/' cgit.mk
	make
	make install

fi

# project-list=/tmp/project-list.txt

# CGIT CONFIGURATION

cat << EOF > /etc/cgitrc
cache-scanrc-ttl=0
css=/cgit/cgit.css
logo=/cgit/cgit.png
js=/cgit/cgit.js
virtual-root=/
scan-path=/var/git/
root-title=This is ddelladi's cgit
root-desc=A personal git repo on a website
readme=README
cache-size=0
clone-prefix=https://ddelladi.42.fr
EOF

cat << EOF > /etc/conf.d/spawn-fcgi.cgit
FCGI_PORT=1234
FCGI_PROGRAM=/usr/bin/fcgiwrap
FCGI_USER="nginx"
FCGI_GROUP="nginx"
OPTIONS="-u nginx -g nginx -P /var/run/spawn-fcgi.pid -- /usr/bin/fcgiwrap -f"
EOF


# FCGIWRAP SETUP

if [ ! -f "/etc/init.d/spawn-fcgi.cgit" ];
then
	ln -s /etc/init.d/spawn-fcgi /etc/init.d/spawn-fcgi.cgit
	ln -s /usr/bin/spawn-fcgi /usr/bin/spawn-fcgi.cgit
fi

export SCRIPT_NAME="/cgit"
echo "Cgit starting"
/usr/bin/spawn-fcgi.cgit -n -a 0.0.0.0 -p 1234  /usr/bin/fcgiwrap

#!/bin/sh

#wait for mariadb, then connect with credentials

while ! mariadb -h$DB_HOSTNAME -u$DATABASE_ADMIN -p$DATABASE_ADMIN_PWD $DATABASE_NAME &>/dev/null;
do
    sleep 3
done

if [ ! -f "/var/www/html/wordpress/index.php" ];
then

	# Wordpress

	wp core download --allow-root
	wp config create --dbname=$DATABASE_NAME --dbuser=$DATABASE_ADMIN --dbpass=$DATABASE_ADMIN_PWD --dbhost=$DB_HOSTNAME --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
	wp core install --url=$DOMAIN_NAME/wordpress --title="Inception" --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
	wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root
	wp theme activate twentytwentythree --allow-root


	# Redis

	sed -i "40a define( 'WP_REDIS_HOST', '$REDIS_HOST' );"      wp-config.php
    sed -i "41a define( 'WP_REDIS_PORT', 6379 );"               wp-config.php
    sed -i "42a define( 'WP_REDIS_PASSWORD', '$REDIS_PWD' );"   wp-config.php
    sed -i "42a define( 'WP_REDIS_TIMEOUT', 1 );"               wp-config.php
    sed -i "43a define( 'WP_REDIS_READ_TIMEOUT', 1 );"          wp-config.php
    sed -i "44a define( 'WP_REDIS_DATABASE', 0 );\n"            wp-config.php


	wp plugin install redis-cache --activate --allow-root
    wp plugin update --all --allow-root

else
	echo "Wordpress already installed";
fi

echo "Wordpress starting"

/usr/sbin/php-fpm7 -F -R

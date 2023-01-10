#!/bin/sh

#wait for mariadb, then connect with credentials

while ! mariadb -h$DB_HOSTNAME -u$DATABASE_ADMIN -p$DATABASE_ADMIN_PWD $DATABASE_NAME &>/dev/null;
do
    sleep 3
done

if [ ! -f "/var/www/html/wordpress/index.php" ];
then
	wp core download --allow-root
	wp config create --dbname=$DATABASE_NAME --dbuser=$DATABASE_ADMIN --dbpass=$DATABASE_ADMIN_PWD --dbhost=$DB_HOSTNAME --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
	wp db create --allow-root
	wp core install --url=$DOMAIN_NAME --title="Inception" --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
	wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --skip-email --allow-root
	wp theme activate twentytwentythree --allow-root
else
	echo "Wordpress already installed";
fi

/usr/sbin/php-fpm7 -F -R

#!/bin/sh

#wait for mariadb, then connect with credentials

while ! mariadb -h$MARIADB_HOST -u$MARIADB_USR -p$MARIADB_PWD $MARIADB_NAME &>/dev/null; do
    sleep 3
done

wp core download --path=wp_files --allow-root
wp config create --dbname=$WP_DATABASE_NAME --dbuser=$WP_DATABASE_USER --dbpass=$WP_DATABASE_PWD --dbhost=$MYSQL_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
wp db create
wp core install --url=$DOMAIN_NAME/wordpress --title="Inception" --admin_user=$WP_DATABASE_USER --admin_password=$WP_DATABASE_PWD --admin_email=ddelladi@student.42roma.it --skip-email --allow-root
wp user create $WP_DATABASE_USER $WP_DATABASE_EMAIL --role=author --user_pass=$WP_DATABASE_PWD --allow-root

mv /tmp/index.html /var/www/html/index.html

/usr/sbin/php-fpm7 -F -R

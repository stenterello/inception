#!/bin/sh

#wait for mariadb, then connect with credentials

while ! mariadb -h$DB_HOSTNAME -u$WP_DATABASE_USR -p$WP_DATABASE_PWD $WP_DATABASE_NAME &>/dev/null;
do
    sleep 3
done

wp core download --path=wp_files --allow-root
wp config create --dbname=$WP_DATABASE_NAME --dbuser=$WP_DATABASE_USR --dbpass=$WP_DATABASE_PWD --dbhost=$DB_HOSTNAME --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
wp db create --allow-root
wp core install --url=$DOMAIN_NAME/wordpress --title="Inception" --admin_user=$WP_DATABASE_USR --admin_password=$WP_DATABASE_PWD --admin_email=ddelladi@student.42roma.it --skip-email --allow-root
wp user create $WP_DATABASE_USR $WP_DATABASE_EMAIL --role=author --user_pass=$WP_DATABASE_PWD --allow-root

mv /tmp/index.html /var/www/html/index.html

/usr/sbin/php-fpm7 -F -R

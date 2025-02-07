#!/bin/bash

until mariadb-admin ping -h $DB_HOST -u $DB_USERNAME -p$DB_PASSWORD --silent; do
    echo ">>> Waiting for MariaDB to be ready..."
    sleep 1
done

if ! wp --allow-root core is-installed --path=/var/www/wordpress > /dev/null 2>&1 ;
then
    wp --allow-root core download --path=/var/www/wordpress
    cd /var/www/wordpress
    wp --allow-root config create --dbname=$DB_DATABASE --dbuser=$DB_USERNAME --dbpass=$DB_PASSWORD --dbhost=$DB_HOST
    wp --allow-root core install --url=$WP_URI --title="$WP_TITLE" --admin_user=$WP_USERNAME --admin_password=$WP_PASSWORD --admin_email=$WP_EMAIL
    wp --allow-root plugin update --all
fi

exec "$@"
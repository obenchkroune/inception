#!/bin/bash

until mariadb-admin ping -h $DB_HOST -u $DB_USERNAME -p$DB_PASSWORD --silent > /dev/null 2>&1; do
    echo ">>> Waiting for MariaDB to start..."
    sleep 1
done

{
wp core download --allow-root --path=/var/www/wordpress 

cd /var/www/wordpress

wp config create \
    --allow-root \
    --dbname=$DB_DATABASE \
    --dbuser=$DB_USERNAME \
    --dbpass=$DB_PASSWORD \
    --dbhost=$DB_HOST

wp core install \
    --allow-root \
    --url="$WP_SITE_URI" \
    --title="$WP_SITE_TITLE" \
    --admin_user="$WP_ADMIN_USERNAME" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL"

wp user create \
    --allow-root \
    "$WP_USER_USERNAME" \
    "$WP_USER_EMAIL" \
    --user_pass="$WP_USER_PASSWORD" \
    --porcelain

wp plugin update --all
} 2>/dev/null

echo "Wordpress Up and running!"
exec "$@"
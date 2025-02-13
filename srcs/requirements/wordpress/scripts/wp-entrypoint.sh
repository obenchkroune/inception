#!/bin/sh

set -e

echo "⌚ Waiting for MariaDB to start..."
until mariadb-admin ping -h $DB_HOST -u $DB_USERNAME -p$DB_PASSWORD --silent --skip-ssl > /dev/null 2>&1; do
    sleep 1
done


if ! wp core is-installed --allow-root; then

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

fi

wp plugin update --all

echo "🚀 Wordpress up and running!"
exec "$@"
#!/bin/sh

set -e

if [ -z "$DB_HOST" ] || [ -z "$DB_NAME" ] || [ -z "$DB_USER" ] || [ -z "$DB_PWD" ] || \
    [ -z "$WP_URL" ] || [ -z "$WP_TITLE" ] || [ -z "$WP_ADMIN_USER" ] || \
    [ -z "$WP_ADMIN_PWD" ] || [ -z "$WP_ADMIN_EMAIL" ] || [ -z "$WP_USER" ] || \
    [ -z "$WP_EMAIL" ] || [ -z "$WP_PWD" ];
then
    echo "Missing required environment variables"
    exit 1
fi

echo "⌚ Waiting for MariaDB/Redis to start..."
until nc -z $DB_HOST 3306 && nc -z $REDIS_HOST 6379; do
    sleep 1
done

chmod -R 777 ./wp-content

if ! wp core is-installed --allow-root; then

wp config create \
    --allow-root \
    --dbname=$DB_NAME \
    --dbuser=$DB_USER \
    --dbpass=$DB_PWD \
    --dbhost=$DB_HOST

wp core install \
    --allow-root \
    --url="$WP_URL" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PWD" \
    --admin_email="$WP_ADMIN_EMAIL"

wp user create \
    --allow-root \
    "$WP_USER" \
    "$WP_EMAIL" \
    --user_pass="$WP_PWD" \
    --porcelain

wp plugin install redis-cache \
    --allow-root --activate

fi

wp config set WP_REDIS_HOST "$REDIS_HOST"
wp config set WP_REDIS_PASSWORD "$REDIS_PWD"
wp config set FTP_HOST "$FTP_HOST"
wp config set FTP_USER "$FTP_USER"
wp config set FTP_PASS "$FTP_PWD"
wp config set FTP_SSL true --raw

wp config set SMTP_HOST "mailhog"
wp config set SMTP_PORT 1025 --raw
wp config set SMTP_AUTH false --raw
wp config set SMTP_SECURE ''

wp core update
wp redis enable

echo "🚀 Wordpress up and running!"
exec "$@"
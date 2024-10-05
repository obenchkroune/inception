#!/bin/sh

set -e

until nc -z ${MYSQL_HOST} 3306; do
    echo "waiting for mysql to start..."
    sleep 1
done

rm -f wp-config.php

cp wp-config-sample.php wp-config.php

wp config set DB_NAME "$MYSQL_DATABASE"
wp config set DB_USER "$MYSQL_USER"
wp config set DB_PASSWORD "$MYSQL_PASSWORD"
wp config set DB_HOST "$MYSQL_HOST"

wp core install \
    --url="${WP_URL}" \
    --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN}" \
    --admin_password="${WP_PASSWORD}" \
    --admin_email="${WP_EMAIL}"

exec php-fpm83 -F

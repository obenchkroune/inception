#! /bin/sh

# set -e

# TODO: remove this Trash!!

until mysqladmin ping -h $MYSQL_HOST -u $MYSQL_USERNAME -p$MYSQL_PASSWORD --silent; do
    echo "=> Waiting for MariaDB to be ready..."
    sleep 1
done

if ! wp core is-installed --path=/var/www/wordpress > /dev/null 2>&1 ;
then
    wp core download --path=/var/www/wordpress
    cd /var/www/wordpress
    wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USERNAME --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOST
    wp db create
    wp core install --url=$WP_URI --title="$WP_TITLE" --admin_user=$WP_USERNAME --admin_password=$WP_PASSWORD --admin_email=$WP_EMAIL
    wp plugin update --all
fi

exec php-fpm83 -F -R
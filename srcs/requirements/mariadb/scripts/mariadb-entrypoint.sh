#!/bin/sh

set -e

if [ -z "$DB_ROOT_PASSWORD" ] || [ -z "$DB_DATABASE" ] || [ -z "$DB_USERNAME" ] || [ -z "$DB_PASSWORD" ];
then
    echo "Missing required environment variables"
    exit 1
fi

mariadbd --skip-networking &

echo "⌚ Waiting for MariaDB to start..."
until mariadb-admin -u root -p$DB_ROOT_PASSWORD ping --silent > /dev/null 2>&1; do
    sleep 1
done

mariadb -u root -p$DB_ROOT_PASSWORD <<EOF
DELETE FROM mysql.user WHERE User='';

ALTER USER IF EXISTS 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;

CREATE USER IF NOT EXISTS '$DB_USERNAME'@'localhost' IDENTIFIED BY '$DB_PASSWORD';
CREATE USER IF NOT EXISTS '$DB_USERNAME'@'%' IDENTIFIED BY '$DB_PASSWORD';

CREATE DATABASE IF NOT EXISTS $DB_DATABASE;

GRANT ALL PRIVILEGES ON $DB_DATABASE.* TO '$DB_USERNAME'@'localhost';
GRANT ALL PRIVILEGES ON $DB_DATABASE.* TO '$DB_USERNAME'@'%';

FLUSH PRIVILEGES;
EOF

MARIADB_PID="$(pidof mariadbd)"

kill $MARIADB_PID
wait $MARIADB_PID

exec "$@"
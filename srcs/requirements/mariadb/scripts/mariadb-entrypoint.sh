#!/bin/sh

set -e

if [ -z "$DB_ROOT_PASS" ] || [ -z "$DB_NAME" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASS" ];
then
    echo "Missing required environment variables"
    exit 1
fi

mariadbd --skip-networking &

echo "⌚ Waiting for MariaDB to start..."
until mariadb-admin -u root -p$DB_ROOT_PASS ping --silent > /dev/null 2>&1; do
    sleep 1
done

mariadb -u root -p$DB_ROOT_PASS <<EOF
DELETE FROM mysql.user WHERE User='';

ALTER USER IF EXISTS 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;

CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';

CREATE DATABASE IF NOT EXISTS $DB_NAME;

GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';

FLUSH PRIVILEGES;
EOF

MARIADB_PID="$(pidof mariadbd)"

kill $MARIADB_PID
wait $MARIADB_PID

exec "$@"
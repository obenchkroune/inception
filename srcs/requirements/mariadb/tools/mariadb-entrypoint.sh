#! /bin/bash

set -e

mariadbd --skip-networking &

until mariadb-admin -u root -p$DB_ROOT_PASSWORD ping --silent; do
    echo ">>> Waiting for MariaDB to start..."
    sleep 1
done

mariadb -u root -p$DB_ROOT_PASSWORD <<-EOF
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

kill $(cat /run/mysqld/mysqld.pid)
wait $(cat /run/mysqld/mysqld.pid)

exec $@
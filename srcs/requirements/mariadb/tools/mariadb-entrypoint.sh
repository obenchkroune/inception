#! /bin/sh

set -e

function init() {
    mkdir -p /var/lib/mysql/data
    chown -R mysql:mysql /var/lib/mysql
    mariadb-install-db

    mariadbd&

mysql <<-EOF
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
    DROP USER IF EXISTS 'root'@'%';

    CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;

    CREATE USER IF NOT EXISTS '$MYSQL_USERNAME'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
    CREATE USER IF NOT EXISTS '$MYSQL_USERNAME'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';

    GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USERNAME'@'localhost';
    GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USERNAME'@'%';

    FLUSH PRIVILEGES;
EOF

    killall -TERM mariadbd
}

if [ ! -d /var/lib/mysql/data ]; then
    init
fi

exec mysqld --skip-grant-tables

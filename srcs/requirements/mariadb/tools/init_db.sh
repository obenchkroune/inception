#!/bin/sh

set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    mysqld_safe --datadir='/var/lib/mysql' &
    
    echo -n "starting the mariadb database..."
    until mysqladmin ping &>/dev/null; do
        echo -n "."
        sleep 1
    done

    echo ""

    mysql -u root <<-EOF
        CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
        CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
        FLUSH PRIVILEGES;
EOF

    mysqladmin -u root shutdown
fi

exec mysqld_safe --datadir='/var/lib/mysql'

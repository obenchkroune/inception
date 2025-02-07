#! /bin/sh

set -e

function init() {
    mkdir -p /var/lib/mysql/data
    chown -R mysql:mysql /var/lib/mysql
    chmod 755 -R /var/lib/mysql
    mariadb-install-db

    mariadbd --skip-grant-tables --skip-networking&

    until mysqladmin ping --silent; do
        echo "=> Waiting for mariadb to stop..."
        sleep 1
    done

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
    
    echo "=> Shutting Down Mariadb"

    killall -TERM mariadbd
    wait $(pidof mariadbd)
}

if [ ! -d /var/lib/mysql/data ]; then
    init
fi

echo "=> Starting the mariadb server"

exec mariadbd

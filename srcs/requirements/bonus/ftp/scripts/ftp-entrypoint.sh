#!/bin/sh

set -e

if ! id -u $FTP_USER > /dev/null 2>&1; then
    adduser -D -h /var/www/ $FTP_USER
fi

chown root:root /var/www
mkdir -p /var/www/wordpress
chmod -R 777 /var/www/wordpress
chown -R $FTP_USER /var/www/wordpress

passwd $FTP_USER <<EOF
$FTP_PWD
$FTP_PWD
EOF

exec "$@"
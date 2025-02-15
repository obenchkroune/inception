#!/bin/sh

set -e

if ! id -u $FTP_USER > /dev/null; then
    adduser -D -h /var/www/wordpress $FTP_USER
fi

passwd $FTP_USER <<EOF > /dev/null
$FTP_PWD
$FTP_PWD
EOF

chown -R $FTP_USER /var/www/wordpress

mkdir -p /run/proftpd

openssl genpkey -algorithm RSA \
    -out /etc/ssl/private/server.key \
    -pkeyopt rsa_keygen_bits:2048

openssl req -new \
    -key /etc/ssl/private/server.key \
    -out /etc/ssl/private/server.csr \
    -subj "$CERT_SUBJECT"

openssl x509 -req -days 365 \
    -in /etc/ssl/private/server.csr \
    -signkey /etc/ssl/private/server.key \
    -out /etc/ssl/certs/server.crt

exec "$@"
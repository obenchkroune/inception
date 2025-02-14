#!/bin/sh

set -e

if [ -z "$CERT_SUBJECT" ];
then
    echo "CERT_SUBJECT is not set"
    exit 1
fi

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
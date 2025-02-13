#!/bin/sh

set -xe

cd "$(dirname "$0")"

openssl genpkey -algorithm RSA -out ../conf/ssl/server.key

openssl req -new \
    -key ../conf/ssl/server.key \
    -out ../conf/ssl/server.csr \
    -subj "/C=MA/ST=Rhamna/L=Ben Guerir/O=1337/OU=IT/CN=obenchkr.42.fr"

openssl x509 -req -days 365 \
    -in ../conf/ssl/server.csr \
    -signkey ../conf/ssl/server.key \
    -out ../conf/ssl/server.crt
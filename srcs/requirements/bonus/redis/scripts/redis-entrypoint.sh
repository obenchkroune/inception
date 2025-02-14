#!/bin/sh

set -e

sed -i -E 's/^[[:space:]]*#?[[:space:]]*requirepass.*/requirepass '$REDIS_PWD'/1' /etc/redis.conf
sed -i -E 's/^[[:space:]]*#?[[:space:]]*protected-mode.*/protected-mode yes/1' /etc/redis.conf
sed -i -E 's/^bind .*/bind * -::*/1' /etc/redis.conf

exec "$@"
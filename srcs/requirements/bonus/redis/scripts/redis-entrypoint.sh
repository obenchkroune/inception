#!/bin/sh

set -e

sed -i -E 's/^requirepass.*/requirepass '$REDIS_PWD'/1' /etc/redis.conf

exec "$@"
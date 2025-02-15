#!/bin/sh

set -e

if [ -z "$REDIS_PWD" ];
then
    echo "Missing required environment variables"
    exit 1
fi

sed -i -E 's/^requirepass.*/requirepass '$REDIS_PWD'/1' /etc/redis.conf

exec "$@"
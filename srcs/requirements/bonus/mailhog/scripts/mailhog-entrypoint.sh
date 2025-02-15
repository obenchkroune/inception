#!/bin/sh

set -e

if [ -z "$MAILHOG_USER" ] || [ -z "$MAILHOG_PASS" ]; then
    echo "Missing required environment variables"
    exit 1
fi
echo "$MAILHOG_USER:$(MailHog bcrypt $MAILHOG_PASS)" > .auth

exec "$@"
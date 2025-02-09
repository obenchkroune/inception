#!/bin/sh

set -e

sed -i "0,/^[[:space:]]*server_name .*/s/server_name .*/server_name $WP_SITE_URI;/1" /etc/nginx/http.d/default.conf

exec "$@"
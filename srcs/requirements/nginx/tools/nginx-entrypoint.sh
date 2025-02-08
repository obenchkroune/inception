#!/bin/bash

set -e

sed -i "0,/^[[:space:]]*server_name .*/s/[[:space:]]server_name .*/server_name $WP_SITE_URI;/1" /etc/nginx/sites-available/default

exec "$@"
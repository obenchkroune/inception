#! /bin/sh

set -e

mariadbd&

mysql <<-EOF
# Query here
EOF

killall -TERM mariadbd

exec mariadbd

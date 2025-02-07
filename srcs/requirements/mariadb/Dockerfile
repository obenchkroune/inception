FROM alpine:3.20

RUN apk update && apk add --no-cache mariadb mariadb-client mariadb-server-utils

COPY conf/mariadb-server.cnf /etc/my.cnf.d/
COPY ./tools/mariadb-entrypoint.sh /usr/bin/mariadb-entrypoint.sh

RUN chmod +x /usr/bin/mariadb-entrypoint.sh

VOLUME [ "/var/lib/mysql" ]

ENTRYPOINT [ "mariadb-entrypoint.sh" ]
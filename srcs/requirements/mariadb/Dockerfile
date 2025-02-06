FROM alpine:3.20

RUN apk update && apk add --no-cache mariadb mariadb-server-utils

COPY conf/mariadb-server.cnf /etc/my.conf.d/

RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql \
    && chown -R mysql:mysql /var/lib/mysql

VOLUME [ "/var/lib/mysql" ]


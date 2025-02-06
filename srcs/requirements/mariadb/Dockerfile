FROM alpine:3.20

RUN apk update && apk add --no-cache mariadb mariadb-client mariadb-server-utils

COPY conf/mariadb-server.cnf /etc/my.conf.d/

RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql \
    && chown -R mysql:mysql /var/lib/mysql

VOLUME [ "/var/lib/mysql" ]

COPY ./tools/mariadb-entrypoint.sh /usr/bin/mariadb-entrypoint.sh

RUN chmod +x /usr/bin/mariadb-entrypoint.sh

USER mysql

ENTRYPOINT [ "mariadb-entrypoint.sh" ]
FROM alpine:3.21

RUN apk update && apk add --no-cache mariadb mariadb-client

COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY ./scripts/mariadb-entrypoint.sh /usr/local/bin/mariadb-entrypoint.sh

RUN chmod +x /usr/local/bin/mariadb-entrypoint.sh

RUN mkdir -p /run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql

RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql

VOLUME [ "/var/lib/mysql" ]

ENTRYPOINT [ "mariadb-entrypoint.sh" ]

CMD [ "mariadbd", "--datadir=/var/lib/mysql", "--user=mysql", "--bind-address=0.0.0.0" ]
FROM alpine:3.20

RUN apk update && apk add mariadb mariadb-client

COPY ./tools/mariadb-server.cnf /etc/my.cnf.d/

COPY ./tools/init_db.sh /scripts/

RUN chmod +x /scripts/init_db.sh

ENTRYPOINT [ "/scripts/init_db.sh" ]

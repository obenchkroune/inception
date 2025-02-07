FROM debian:bullseye

RUN apt update && apt install -y mariadb-server mariadb-client

COPY ./tools/mariadb-entrypoint.sh /usr/local/bin/mariadb-entrypoint.sh

RUN chmod +x /usr/local/bin/mariadb-entrypoint.sh && \
    mkdir -p /run/mysqld && \
    chown -R mysql /run/mysqld/ && \
    chown -R mysql /var/lib/mysql

VOLUME [ "/var/lib/mysql" ]

ENTRYPOINT [ "mariadb-entrypoint.sh" ]

CMD [ "mariadbd", "--bind-address=0.0.0.0" ]
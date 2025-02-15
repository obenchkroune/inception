FROM alpine:3.21

RUN apk update && apk add --no-cache proftpd openssl proftpd-mod_tls

COPY ./scripts/ftp-entrypoint.sh /usr/local/bin/ftp-entrypoint.sh

COPY ./conf/proftpd.conf /etc/proftpd/proftpd.conf

RUN chmod +x /usr/local/bin/ftp-entrypoint.sh

EXPOSE 21
EXPOSE 20

VOLUME [ "/var/www/wordpress" ]

ENTRYPOINT [ "ftp-entrypoint.sh" ]

CMD [ "proftpd", "--nodaemon" ]